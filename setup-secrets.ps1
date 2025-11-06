# ================================================
# SUPABASE SECRETS CONFIGURATION SCRIPT (PowerShell)
# ================================================
# This script helps you set up all required
# environment secrets for Supabase Edge Functions
# ================================================

$ErrorActionPreference = "Stop"

Write-Host "`n🔐 Supabase Secrets Configuration" -ForegroundColor Blue
Write-Host "==============================================" -ForegroundColor Blue
Write-Host ""

# Check if supabase CLI is available
$supabaseCmd = Get-Command supabase -ErrorAction SilentlyContinue
if (-not $supabaseCmd) {
    Write-Host "❌ Supabase CLI is not installed" -ForegroundColor Red
    Write-Host "Please install it first: https://supabase.com/docs/guides/cli" -ForegroundColor Yellow
    Write-Host "See WINDOWS_INSTALLATION.md for installation instructions" -ForegroundColor Yellow
    exit 1
}

Write-Host "✓ Supabase CLI found" -ForegroundColor Green
Write-Host ""

# Check if linked
if (-not (Test-Path ".supabase/config.toml")) {
    Write-Host "⚠️  Not linked to Supabase project" -ForegroundColor Yellow
    Write-Host "Linking now..."
    supabase link --project-ref wzlqbrglftrkxrfztcqd
}

Write-Host "This script will help you configure the following secrets:"
Write-Host "  1. RESEND_API_KEY - For sending emails"
Write-Host "  2. SUPABASE_SERVICE_ROLE_KEY - For database access"
Write-Host "  3. VITE_APP_URL - Your production app URL"
Write-Host "  4. SUPABASE_URL - Your Supabase project URL"
Write-Host ""
Write-Host "⚠️  Secrets will be stored securely in Supabase" -ForegroundColor Yellow
Write-Host ""

# Function to set a secret
function Set-SupabaseSecret {
    param(
        [string]$SecretName,
        [string]$Description,
        [string]$DefaultValue = ""
    )

    Write-Host ""
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
    Write-Host "Setting: $SecretName" -ForegroundColor Blue
    Write-Host "Description: $Description"

    if ($DefaultValue) {
        Write-Host "Current/Default: $DefaultValue"
    }

    Write-Host ""
    $secretValue = Read-Host "Enter value (or press Enter to skip)"

    if ($secretValue) {
        Write-Host "Setting secret..." -ForegroundColor Yellow
        try {
            supabase secrets set "${SecretName}=${secretValue}"
            Write-Host "✓ $SecretName set successfully" -ForegroundColor Green
        }
        catch {
            Write-Host "✗ Failed to set $SecretName" -ForegroundColor Red
        }
    }
    else {
        Write-Host "⊘ Skipped $SecretName" -ForegroundColor Yellow
    }
}

# 1. RESEND_API_KEY
Set-SupabaseSecret `
    -SecretName "RESEND_API_KEY" `
    -Description "Resend API key for sending emails (starts with re_)"

# 2. SUPABASE_SERVICE_ROLE_KEY
Write-Host ""
Write-Host "📝 To get your Service Role Key:" -ForegroundColor Yellow
Write-Host "   1. Go to: https://supabase.com/dashboard/project/wzlqbrglftrkxrfztcqd/settings/api"
Write-Host "   2. Scroll to 'Service Role Key' (secret)"
Write-Host "   3. Click to reveal and copy"
Write-Host ""

Set-SupabaseSecret `
    -SecretName "SUPABASE_SERVICE_ROLE_KEY" `
    -Description "Supabase Service Role key (NOT the anon key!)"

# 3. VITE_APP_URL
Set-SupabaseSecret `
    -SecretName "VITE_APP_URL" `
    -Description "Your production app URL" `
    -DefaultValue "https://groundupcareers.app"

# 4. SUPABASE_URL
Set-SupabaseSecret `
    -SecretName "SUPABASE_URL" `
    -Description "Your Supabase project URL" `
    -DefaultValue "https://wzlqbrglftrkxrfztcqd.supabase.co"

# Summary
Write-Host ""
Write-Host "==============================================" -ForegroundColor Blue
Write-Host "📊 Configuration Complete!" -ForegroundColor Blue
Write-Host "==============================================" -ForegroundColor Blue
Write-Host ""
Write-Host "Verifying secrets..." -ForegroundColor Yellow
Write-Host ""

supabase secrets list

Write-Host ""
Write-Host "✅ All secrets configured!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Deploy edge functions: .\deploy-functions.ps1"
Write-Host "  2. Test email sending"
Write-Host "  3. Deploy to Vercel"
Write-Host ""
