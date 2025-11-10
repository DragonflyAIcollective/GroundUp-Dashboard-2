# Supabase Email Confirmation Setup Guide

This guide explains how to enable sign-up confirmation emails for GroundUp Careers.

## Issue

Users are not receiving sign-up confirmation emails because email confirmations are **disabled** in the Supabase project settings.

## Architecture

Your application uses **two separate email systems**:

1. **Supabase Auth Emails** - For user authentication (sign-up confirmations, password resets)
2. **Resend** - For admin notifications (new client registered, job posted, etc.)

## Fix Required: Enable Email Confirmations in Production

### Step 1: Access Supabase Dashboard

1. Go to [Supabase Dashboard](https://supabase.com/dashboard)
2. Navigate to your project: `wzlqbrglftrkxrfztcqd`

### Step 2: Enable Email Confirmations

#### Option A: Via Authentication Settings (Recommended)

1. In the left sidebar, click **Authentication**
2. Click **Providers** or **Email** tab
3. Look for **"Confirm email"** or **"Enable email confirmations"** setting
4. **Toggle it ON** ✅
5. Click **Save**

#### Option B: Via Project Configuration

1. In the left sidebar, click **Project Settings** (gear icon)
2. Click **Auth** under Configuration
3. Scroll to **Email Auth** section
4. Find **"Enable email confirmations"** toggle
5. **Turn it ON** ✅
6. Click **Save**

### Step 3: Configure Redirect URLs

Ensure your production URL is whitelisted for auth redirects:

1. Go to **Authentication** → **URL Configuration**
2. Set **Site URL** to: `https://groundupcareers.app`
3. Add **Redirect URLs**:
   - `https://groundupcareers.app/auth/callback`
   - `https://groundupcareers.app/**` (wildcard for all app routes)
4. Click **Save**

### Step 4: Customize Email Template (Optional)

You can customize the confirmation email template:

1. Go to **Authentication** → **Email Templates**
2. Select **"Confirm signup"** template
3. Customize the template with your branding
4. Available variables:
   - `{{ .ConfirmationURL }}` - The confirmation link
   - `{{ .SiteURL }}` - Your app URL
   - `{{ .Email }}` - User's email address
5. Click **Save**

## Verification Steps

After enabling email confirmations, test the complete flow:

### Test Sign-Up Flow

1. Open your app: https://groundupcareers.app
2. Click **Sign Up**
3. Fill in the registration form with a **real email address**
4. Submit the form
5. Check your email inbox (and spam folder)
6. You should receive a confirmation email from Supabase
7. Click the confirmation link in the email
8. You should be redirected to your app and logged in

### Check Auth Logs

1. In Supabase Dashboard, go to **Authentication** → **Users**
2. Find the test user you just created
3. Verify the user's email is **confirmed** (green checkmark)

### Check Supabase Logs

1. Go to **Logs** → **Auth Logs**
2. Look for any errors related to email sending
3. Common issues:
   - SMTP configuration errors
   - Rate limiting
   - Invalid redirect URLs

## Troubleshooting

### Email Not Received

1. **Check Spam Folder** - Supabase emails may be flagged as spam initially
2. **Verify Email Service** - Ensure Supabase's email service is not having issues
3. **Check Rate Limits** - Supabase has rate limits on emails (check Auth logs)
4. **Check Email Quota** - Free tier has email limits

### Email Received But Link Doesn't Work

1. **Check Redirect URLs** - Ensure `https://groundupcareers.app` is whitelisted
2. **Check Site URL** - Should be set to `https://groundupcareers.app`
3. **Check Callback Handler** - File: `src/pages/auth/AuthCallbackPage.tsx`

### User Can't Login After Confirmation

1. **Check Email Confirmation Status** - In Users table
2. **Check Auth Logs** - For any authentication errors
3. **Clear Browser Cache** - Sometimes cached auth state causes issues

## Environment Variables

Ensure these are set correctly in your production environment:

```bash
# Frontend (.env or Vercel environment variables)
VITE_SUPABASE_URL=https://wzlqbrglftrkxrfztcqd.supabase.co
VITE_SUPABASE_ANON_KEY=your_anon_key_here
VITE_APP_URL=https://groundupcareers.app

# Supabase Secrets (for Edge Functions)
RESEND_API_KEY=re_your_resend_api_key
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
```

## Local Development

For local development, the fix has already been applied in `supabase/config.toml`:

```toml
[auth.email]
enable_signup = true
enable_confirmations = true  # Changed from false to true
```

Run local Supabase:
```bash
supabase start
```

## Advanced: Custom SMTP (Optional)

If you want to use a custom SMTP provider instead of Supabase's built-in email:

1. Go to **Project Settings** → **Auth**
2. Scroll to **SMTP Settings**
3. Configure your SMTP provider (e.g., SendGrid, Postmark)
4. Test the configuration

**Note:** For most use cases, Supabase's built-in email service is sufficient and recommended.

## Email System Summary

### Supabase Auth Emails (Sign-Up Confirmations)
- **Used for:** User sign-up confirmations, password resets, magic links
- **Configuration:** Supabase Dashboard → Authentication → Email Templates
- **Status:** Currently DISABLED (needs to be enabled)
- **Cost:** Included in Supabase plan

### Resend Emails (Admin Notifications)
- **Used for:** Notifying admins about new clients, job posts, etc.
- **Configuration:** Supabase Secrets (`RESEND_API_KEY`)
- **Status:** Should be working if API key is set
- **Cost:** Resend pricing (free tier available)

## Support

If you continue to have issues:

1. Check Supabase Status: https://status.supabase.com
2. Review Supabase Docs: https://supabase.com/docs/guides/auth/auth-email
3. Check Auth Logs in Supabase Dashboard
4. Contact Supabase Support if needed

## Related Files

- Sign-up component: `src/pages/auth/AuthPage.tsx`
- Auth context: `src/contexts/AuthContext.tsx`
- Callback handler: `src/pages/auth/AuthCallbackPage.tsx`
- Local config: `supabase/config.toml`
- Resend setup: `DNS_SETUP_RESEND.md`
