import { serve } from 'https://deno.land/std@0.190.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.57.4';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers':
    'authorization, x-client-info, apikey, content-type',
};

serve(async req => {
  // Handle CORS preflight requests
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    // Create Supabase client with service role key (has admin privileges)
    const supabaseAdmin = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '',
      {
        auth: {
          autoRefreshToken: false,
          persistSession: false,
        },
      }
    );

    // Verify the requesting user is an admin
    const authHeader = req.headers.get('Authorization');
    if (!authHeader) {
      return new Response(
        JSON.stringify({ error: 'Missing authorization header' }),
        {
          status: 401,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        }
      );
    }

    // Get the user from the auth header
    const token = authHeader.replace('Bearer ', '');
    const {
      data: { user },
      error: userError,
    } = await supabaseAdmin.auth.getUser(token);

    if (userError || !user) {
      return new Response(
        JSON.stringify({ error: 'Invalid authentication token' }),
        {
          status: 401,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        }
      );
    }

    // Check if user is admin
    const { data: profile, error: profileError } = await supabaseAdmin
      .from('profiles')
      .select('role')
      .eq('user_id', user.id)
      .single();

    if (profileError || !profile || profile.role !== 'admin') {
      return new Response(
        JSON.stringify({ error: 'Unauthorized: Admin access required' }),
        {
          status: 403,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        }
      );
    }

    // Fetch all clients using direct REST API to bypass PostgREST relationship validation
    console.log('Fetching clients...');
    const supabaseUrl = Deno.env.get('SUPABASE_URL') ?? '';
    const serviceRoleKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '';

    const clientsResponse = await fetch(
      `${supabaseUrl}/rest/v1/clients?select=id,user_id,company_name,contact_phone,address,street1,street2,city,state,zip,welcome_email_sent,created_at,updated_at&order=created_at.desc`,
      {
        headers: {
          'apikey': serviceRoleKey,
          'Authorization': `Bearer ${serviceRoleKey}`,
          'Content-Type': 'application/json',
          'Prefer': 'return=representation'
        }
      }
    );

    if (!clientsResponse.ok) {
      const errorText = await clientsResponse.text();
      console.error('Error fetching clients:', errorText);
      throw new Error(`Failed to fetch clients: ${errorText}`);
    }

    const allClients = await clientsResponse.json();
    console.log(`Found ${allClients?.length || 0} clients`);

    // Fetch all profiles for these clients - filter out null/undefined user_ids
    const userIds = (allClients || [])
      .map(client => client.user_id)
      .filter(id => id != null);

    console.log(`Found ${userIds.length} unique user IDs`);

    if (userIds.length === 0) {
      return new Response(
        JSON.stringify({
          success: true,
          clients: [],
        }),
        {
          status: 200,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        }
      );
    }

    console.log('Fetching profiles...');
    const profilesResponse = await fetch(
      `${supabaseUrl}/rest/v1/profiles?select=user_id,email,full_name,role,is_active&user_id=in.(${userIds.join(',')})`,
      {
        headers: {
          'apikey': serviceRoleKey,
          'Authorization': `Bearer ${serviceRoleKey}`,
          'Content-Type': 'application/json',
          'Prefer': 'return=representation'
        }
      }
    );

    if (!profilesResponse.ok) {
      const errorText = await profilesResponse.text();
      console.error('Error fetching profiles:', errorText);
      throw new Error(`Failed to fetch profiles: ${errorText}`);
    }

    const profiles = await profilesResponse.json();
    console.log(`Found ${profiles?.length || 0} profiles`);

    // Create a map of profiles by user_id for easy lookup
    const profilesMap = new Map(
      profiles?.map(profile => [profile.user_id, profile]) || []
    );

    // Merge clients with their profiles
    const clients = (allClients || [])
      .map(client => ({
        ...client,
        profiles: profilesMap.get(client.user_id) || null,
      }))
      .filter(client => client.profiles && client.profiles.role === 'client');

    // Map clients with basic status (skip auth user lookup for now)
    const clientsWithStatus = clients?.map(client => {
      return {
        ...client,
        invitation_status: 'confirmed', // Default to confirmed for now
        email_confirmed_at: null,
      };
    });

    return new Response(
      JSON.stringify({
        success: true,
        clients: clientsWithStatus || [],
      }),
      {
        status: 200,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      }
    );
  } catch (error) {
    console.error('Error fetching clients:', error);
    console.error('Error details:', JSON.stringify(error, null, 2));
    return new Response(
      JSON.stringify({
        error: error.message || 'An unexpected error occurred',
        details: error.toString(),
        stack: error.stack,
      }),
      {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      }
    );
  }
});
