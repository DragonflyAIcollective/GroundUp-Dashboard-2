# GitHub Organization & Service Lockdown Guide
## GroundUp Dashboard - Production Setup

---

## 🎯 Current Situation

**Current Repository**: `DragonflyAIcollective/GroundUp-Dashboard-2`
- This is YOUR development/working repository
- Currently has feature branches only
- Needs to be properly organized for production

**Target Setup**: `GroundUpCareers/GroundUp-Dashboard` (or similar)
- Josh's production organization
- Locked down and secure
- Proper branch management
- All services configured

---

## 📋 Organization Plan

### Phase 1: Repository Organization
### Phase 2: Branch Structure Setup
### Phase 3: Service Lockdown (Supabase, Resend, Vercel, DNS)
### Phase 4: Access Control
### Phase 5: Deployment Pipeline

---

# PHASE 1: Repository Organization

## Option A: Transfer Repository to Josh's Organization (Recommended)

### Step 1: Create GroundUp GitHub Organization (if not exists)

1. **Create Organization**:
   - Go to: https://github.com/organizations/plan
   - Click "Create a free organization"
   - Organization name: `GroundUpCareers` (or whatever Josh prefers)
   - Contact email: Josh's email
   - Account type: Free (or paid if needed)

2. **Invite Members**:
   - Josh as Owner
   - You (jeffgus) as Owner or Admin (for now)

### Step 2: Transfer Repository from DragonflyAI to GroundUp

**⚠️ IMPORTANT**: Before transferring, make sure all work is committed and pushed!

1. **In DragonflyAIcollective/GroundUp-Dashboard-2**:
   - Go to: https://github.com/DragonflyAIcollective/GroundUp-Dashboard-2/settings
   - Scroll to **"Danger Zone"**
   - Click **"Transfer ownership"**
   - Enter new owner: `GroundUpCareers` (or Josh's org name)
   - Confirm the transfer

2. **After Transfer**:
   - Repository will be at: `GroundUpCareers/GroundUp-Dashboard-2`
   - All branches, history, and issues transfer
   - All webhooks and integrations will need to be reconfigured

### Step 3: Update Your Local Git Remote

```bash
# After transfer, update your local repository
git remote set-url origin https://github.com/GroundUpCareers/GroundUp-Dashboard-2.git

# Verify
git remote -v

# Fetch latest
git fetch origin
```

---

## Option B: Fork to Josh's Organization (Alternative)

If you want to keep the DragonflyAI repo:

1. Go to: https://github.com/DragonflyAIcollective/GroundUp-Dashboard-2
2. Click **"Fork"**
3. Select: `GroundUpCareers` organization
4. Repository name: `GroundUp-Dashboard` (clean name)
5. Click **"Create fork"**

This creates a clean copy at: `GroundUpCareers/GroundUp-Dashboard`

---

# PHASE 2: Branch Structure Setup

## Create Proper Branch Structure

### In the GroundUp Repository:

```bash
# 1. Create main production branch from latest working code
git checkout claude/dashboard-rundown-011CV1iSWh5eJ3tn1PNRh67J
git checkout -b main
git push -u origin main

# 2. Set main as default branch in GitHub
# Go to: GitHub → Settings → Branches → Default branch → Change to "main"

# 3. Create staging branch
git checkout -b staging
git push -u origin staging

# 4. Create development branch
git checkout -b development
git push -u origin development
```

### Branch Strategy:

```
main (production)
  ↓
staging (pre-production testing)
  ↓
development (active development)
  ↓
feature/* (individual features)
```

### Branch Protection Rules

**For `main` branch**:

Go to: GitHub → Settings → Branches → Add rule

✅ **Settings to enable**:
- Branch name pattern: `main`
- ☑️ Require pull request before merging
- ☑️ Require approvals: 1
- ☑️ Dismiss stale pull request approvals when new commits are pushed
- ☑️ Require status checks to pass before merging
- ☑️ Require conversation resolution before merging
- ☑️ Require signed commits (optional, but recommended)
- ☑️ Include administrators (even admins must follow rules)
- ☑️ Restrict who can push to matching branches
  - Only allow: Josh, specific deploy accounts

**For `staging` branch**:
- Similar rules but maybe allow more people
- Require approval from at least 1 person

**For `development` branch**:
- Lighter rules
- Allow direct pushes from authorized developers

---

# PHASE 3: Service Lockdown

## 🔐 SUPABASE Security Lockdown

### 1. Organization Setup

**Current**: Project under personal/DragonflyAI account
**Target**: Project under GroundUp organization

#### Create Supabase Organization:

1. Go to: https://supabase.com/dashboard
2. Click organization dropdown
3. "New organization"
4. Name: "GroundUp Careers"
5. Owner: Josh's email

#### Transfer or Recreate Project:

**Option A: Create New Project in GroundUp Org** (Safest):
- Create new project in GroundUp organization
- Use migration scripts to transfer data
- Update all connection strings

**Option B: Transfer Existing Project** (if Supabase supports it):
- Contact Supabase support
- Request project transfer to new organization
- Project ID: `wzlqbrglftrkxrfztcqd`

### 2. Lock Down Access

#### Organization Members:
```
Josh Denton    → Owner
jeffgus        → Admin (temporary - can be downgraded later)
Deploy Bot     → Developer (for CI/CD)
```

#### API Keys Security:

**🔐 Rotate ALL Keys After Transfer**:

1. **Service Role Key** (most powerful):
   - Go to: Settings → API
   - Generate new service role key
   - Update in Vercel environment variables
   - Update in Edge Functions
   - **DO NOT commit to Git!**

2. **Anon/Public Key**:
   - Used in frontend
   - Generate new key
   - Update in Vercel environment variables
   - Update in frontend `.env`

#### Database Policies:

Already secured via RLS (Row Level Security) - verify:

```sql
-- Check RLS is enabled on all tables
SELECT schemaname, tablename, rowsecurity
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY tablename;
```

All should show `rowsecurity = true` ✅

#### Network Restrictions:

In Supabase Dashboard → Settings → Database:
- Enable "Connection pooling"
- Consider enabling "SSL enforcement"
- Set up IP allowlist (optional, for extra security):
  - Add Vercel's IP ranges
  - Add Josh's office IP
  - Add your IP

### 3. Backup Strategy

Set up automated backups:
1. Go to: Settings → Database → Backups
2. Enable daily backups
3. Retention: 7 days minimum
4. Consider enabling PITR (Point-in-time Recovery) on paid plan

---

## 📧 RESEND Security Lockdown

### 1. Account Organization

**Current**: Under personal account
**Target**: Under GroundUp organization/team

#### Option A: Transfer to GroundUp Account:

1. Go to: https://resend.com/settings
2. Check if "Teams" or "Organizations" feature is available
3. If yes: Create team "GroundUp Careers"
4. Transfer domain and API keys

#### Option B: Create New Resend Account:

1. Sign up with Josh's email or company email
2. Verify domain: `groundupcareers.com`
3. Generate new API keys

### 2. Domain Verification

**Domain**: `groundupcareers.com`

#### DNS Records Required:

```
Type: TXT
Name: _resend
Value: [Resend will provide this]
TTL: 3600

Type: MX
Name: @ (or groundupcareers.com)
Value: feedback-smtp.resend.com
Priority: 10
TTL: 3600

Type: TXT (DKIM)
Name: resend._domainkey
Value: [Resend will provide this]
TTL: 3600

Type: TXT (SPF)
Name: @
Value: v=spf1 include:_spf.resend.com ~all
TTL: 3600
```

#### Verify Status:

In Resend Dashboard:
- Domain Status: Verified ✅
- SPF: Valid ✅
- DKIM: Valid ✅
- DMARC: Valid ✅

### 3. API Key Security

**🔐 Generate New API Key**:

1. Go to: Resend → API Keys
2. Create new key: "Production - Vercel"
3. Permissions: Send emails only (not full access)
4. Copy key (only shown once!)
5. Store in Vercel environment variables
6. **Delete old key after testing**

**Environment Variable**:
```
RESEND_API_KEY=re_xxxxxxxxxxxxxxxxxxxxx
```

### 4. Email From Address

Set up proper sender:
- From: `noreply@groundupcareers.com`
- Display name: "Ground Up Careers"
- Reply-to: `support@groundupcareers.com` (if exists)

---

## 🚀 VERCEL Deployment Lockdown

### 1. Team/Organization Setup

**Current**: Under personal account
**Target**: Under GroundUp team

#### Create Vercel Team:

1. Go to: https://vercel.com/dashboard
2. Click profile → "Create Team"
3. Team name: "GroundUp Careers"
4. Slug: `groundup-careers`
5. Owner: Josh's email

#### Transfer Project:

1. Go to existing project settings
2. "Transfer Project"
3. Select: "GroundUp Careers" team
4. Confirm transfer

Or create new project in team:
1. In GroundUp team dashboard
2. "Add New..." → "Project"
3. Import from: `GroundUpCareers/GroundUp-Dashboard-2`

### 2. Team Members & Roles

```
Josh Denton    → Owner (full access)
jeffgus        → Admin (can manage but not delete)
Deploy Bot     → Member (deploy only)
```

### 3. Production Domain Setup

#### Custom Domain Configuration:

**Production Domain**: `groundupcareers.com` or `app.groundupcareers.com`

1. **In Vercel**:
   - Go to: Project → Settings → Domains
   - Add domain: `app.groundupcareers.com`
   - Vercel provides DNS records

2. **In DNS Provider** (see Phase 3D below):
   - Add A/CNAME records as instructed
   - Wait for propagation (up to 48 hours)
   - Vercel will auto-configure SSL

#### Recommended Domains:

```
Production:  app.groundupcareers.com  → Vercel production
Staging:     staging.groundupcareers.com → Vercel preview
Development: dev.groundupcareers.com → Vercel preview (optional)
```

### 4. Environment Variables

**🔐 Set Production Environment Variables**:

Go to: Vercel → Project → Settings → Environment Variables

**Production Environment**:

```bash
# Supabase
VITE_SUPABASE_URL=https://wzlqbrglftrkxrfztcqd.supabase.co
VITE_SUPABASE_ANON_KEY=eyJ... (new key after rotation)
SUPABASE_SERVICE_ROLE_KEY=eyJ... (new key, for edge functions)

# Application
VITE_APP_URL=https://app.groundupcareers.com

# Stripe
VITE_STRIPE_PUBLIC_KEY=pk_live_... (LIVE key for production!)
STRIPE_SECRET_KEY=sk_live_... (LIVE key, never commit!)
STRIPE_WEBHOOK_SECRET=whsec_... (from Stripe webhook settings)

# Resend
RESEND_API_KEY=re_... (new key after rotation)

# Feature Flags (optional)
NODE_ENV=production
```

**Preview/Staging Environment**:

Same variables but with test/staging keys:
```bash
VITE_STRIPE_PUBLIC_KEY=pk_test_...
STRIPE_SECRET_KEY=sk_test_...
```

### 5. Deployment Settings

**Branch Configuration**:

- **Production Branch**: `main`
  - Auto-deploy on push: YES
  - Domain: `app.groundupcareers.com`

- **Preview Branches**: `staging`, `development`
  - Auto-deploy on push: YES
  - Generate preview URLs automatically

- **Feature Branches**: `feature/*`, `claude/*`
  - Deploy on PR: YES
  - Require approval: Optional

### 6. Security Headers

Go to: Vercel → Project → Settings → Headers

Add security headers via `vercel.json`:

```json
{
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "X-Frame-Options",
          "value": "DENY"
        },
        {
          "key": "X-Content-Type-Options",
          "value": "nosniff"
        },
        {
          "key": "X-XSS-Protection",
          "value": "1; mode=block"
        },
        {
          "key": "Referrer-Policy",
          "value": "strict-origin-when-cross-origin"
        },
        {
          "key": "Permissions-Policy",
          "value": "camera=(), microphone=(), geolocation=()"
        }
      ]
    }
  ]
}
```

### 7. Webhook Protection

**Vercel Deploy Hooks** (for CI/CD):

1. Generate deploy hook
2. Store in GitHub Secrets
3. Use in GitHub Actions if needed

---

## 🌐 DNS Configuration & Domain Lockdown

### 1. Domain Registrar Access

**Domain**: `groundupcareers.com`

**Current Registrar**: (GoDaddy? Namecheap? Google Domains?)

#### Lock Down Registrar Account:

1. **Owner**: Josh's email
2. **2FA**: Enable two-factor authentication ✅
3. **Domain Lock**: Enable transfer lock ✅
4. **Auto-renew**: Enable ✅
5. **Privacy Protection**: Enable WHOIS privacy ✅
6. **Contact Info**: Update to company address

#### Additional Security:

- Set strong password (password manager)
- Add recovery email
- Document where domain is registered
- Set calendar reminder for renewal (even with auto-renew)

### 2. DNS Provider Setup

**Options**:
- Use registrar's DNS (GoDaddy, Namecheap, etc.)
- Use Cloudflare DNS (recommended for better performance & security)
- Use Vercel DNS (simplest for Vercel deployments)

#### Option A: Cloudflare DNS (Recommended)

**Benefits**: Free, fast, DDoS protection, analytics

1. **Sign up**: https://cloudflare.com
2. **Add Site**: `groundupcareers.com`
3. **Change Nameservers** at registrar:
   ```
   NS1: chad.ns.cloudflare.com
   NS2: lina.ns.cloudflare.com
   (Cloudflare will provide specific values)
   ```
4. **Wait for propagation** (24-48 hours)

#### Option B: Vercel DNS (Simplest)

1. In Vercel: Project → Domains
2. Click "Use Vercel DNS"
3. Update nameservers at registrar to Vercel's nameservers
4. Vercel manages everything automatically

### 3. Required DNS Records

**For Production App**:

```dns
# Main application
Type: CNAME
Name: app
Value: cname.vercel-dns.com.
TTL: 300

# Or if using Cloudflare
Type: A
Name: app
Value: 76.76.21.21 (Vercel IP)
TTL: 300
Proxy: Enabled (orange cloud)
```

**For Email (Resend)**:

```dns
# Resend verification
Type: TXT
Name: _resend
Value: [from Resend dashboard]
TTL: 3600

# DKIM for email authentication
Type: TXT
Name: resend._domainkey
Value: [from Resend dashboard]
TTL: 3600

# SPF record
Type: TXT
Name: @
Value: v=spf1 include:_spf.resend.com ~all
TTL: 3600

# DMARC policy (optional but recommended)
Type: TXT
Name: _dmarc
Value: v=DMARC1; p=quarantine; rua=mailto:dmarc@groundupcareers.com
TTL: 3600
```

**For Root Domain (www redirect)**:

```dns
# Redirect www to app.groundupcareers.com
Type: CNAME
Name: www
Value: cname.vercel-dns.com.
TTL: 300

# Or simple A record
Type: A
Name: @
Value: 76.76.21.21 (Vercel IP)
TTL: 300
```

**For Supabase** (if custom domain):

```dns
# If using custom Supabase domain
Type: CNAME
Name: db
Value: db.wzlqbrglftrkxrfztcqd.supabase.co.
TTL: 3600
```

### 4. SSL Certificate

**Automatic with Vercel**:
- Vercel auto-provisions Let's Encrypt certificates
- Auto-renews every 90 days
- Covers both root and subdomains

**Verify**:
- Go to: https://app.groundupcareers.com
- Look for 🔒 in browser
- Certificate should be valid

**If using Cloudflare**:
- Enable "Full (strict)" SSL mode
- Let Cloudflare handle certificate

### 5. Monitoring & Security

**Set up monitoring**:
- Cloudflare: Enable "Always Use HTTPS"
- Set up email alerts for SSL expiration
- Enable "HSTS" (HTTP Strict Transport Security)

**DNS Security**:
- Enable DNSSEC (if supported by registrar)
- Use Cloudflare's firewall rules
- Rate limiting to prevent DDoS

---

# PHASE 4: Access Control & Permissions

## 🔐 Access Matrix

### GitHub Repository

| Person | Role | Permissions |
|--------|------|-------------|
| Josh Denton | Owner | Full access, delete repo |
| Jeff (jeffgus) | Admin | Push to branches, manage settings |
| Deploy Bot | Write | Deploy only, no settings |
| Other Developers | Write | Create branches, PRs only |

### Supabase

| Person | Role | Access |
|--------|------|--------|
| Josh Denton | Owner | Full database & project access |
| Jeff (jeffgus) | Admin | Full access (temp - can downgrade) |
| Deploy Bot | Service Role | API access only |

### Resend

| Person | Role | Access |
|--------|------|--------|
| Josh Denton | Owner | Full account access |
| Jeff (jeffgus) | Admin | Send emails, view logs |

### Vercel

| Person | Role | Access |
|--------|------|--------|
| Josh Denton | Owner | Full project access |
| Jeff (jeffgus) | Admin | Deploy, manage settings |
| Deploy Bot | Member | Deploy only |

### Domain Registrar

| Person | Role | Access |
|--------|------|--------|
| Josh Denton | Owner | Full control |
| Jeff (jeffgus) | Technical Contact | Emergency access only |

---

## 📋 PHASE 5: Deployment Pipeline

### Setup CI/CD with GitHub Actions

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to Production

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Setup Node
        uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test

      - name: Build
        run: npm run build
        env:
          VITE_SUPABASE_URL: ${{ secrets.VITE_SUPABASE_URL }}
          VITE_SUPABASE_ANON_KEY: ${{ secrets.VITE_SUPABASE_ANON_KEY }}

      - name: Deploy to Vercel
        uses: amondnet/vercel-action@v20
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          production: true
```

---

## 🎯 Implementation Checklist

### Week 1: Organization & Repository

- [ ] Create GroundUp GitHub organization
- [ ] Invite Josh as owner
- [ ] Transfer repository from DragonflyAI to GroundUp
- [ ] Create main, staging, development branches
- [ ] Set up branch protection rules
- [ ] Update local git remotes

### Week 2: Supabase Migration

- [ ] Create GroundUp organization in Supabase
- [ ] Transfer or recreate project
- [ ] Rotate all API keys
- [ ] Update environment variables everywhere
- [ ] Test database connections
- [ ] Set up automated backups
- [ ] Document connection strings securely

### Week 3: Email & DNS

- [ ] Set up Resend under GroundUp account
- [ ] Verify domain ownership
- [ ] Configure DNS records (SPF, DKIM, DMARC)
- [ ] Generate new API keys
- [ ] Test email sending
- [ ] Update Vercel environment variables
- [ ] Lock down domain registrar account

### Week 4: Vercel & Deployment

- [ ] Create GroundUp team in Vercel
- [ ] Transfer project to team
- [ ] Configure production domain
- [ ] Set up preview domains
- [ ] Update all environment variables
- [ ] Configure branch deployments
- [ ] Add security headers
- [ ] Test full deployment pipeline

### Week 5: Security & Access

- [ ] Review all access permissions
- [ ] Enable 2FA on all services
- [ ] Document all credentials in password manager
- [ ] Set up monitoring and alerts
- [ ] Create disaster recovery plan
- [ ] Final security audit

---

## 📝 Documentation & Handoff

### Required Documentation

1. **Service Access Document**:
   - All usernames/emails
   - Where passwords are stored (1Password, LastPass, etc.)
   - 2FA backup codes location
   - Emergency contacts

2. **Deployment Guide**:
   - How to deploy to production
   - How to rollback
   - Emergency procedures
   - Who to call if down

3. **Environment Variables List**:
   - What each variable does
   - Where to find values
   - How to rotate keys

4. **DNS Record Reference**:
   - Current DNS configuration
   - Provider login info
   - How to update records

### Password Manager Setup

**Recommended**: 1Password Teams or LastPass Business

**Structure**:
```
GroundUp Careers
├── GitHub
│   ├── Josh's Account
│   └── Deploy Bot Token
├── Supabase
│   ├── Organization Login
│   ├── Service Role Key
│   └── Anon Key
├── Resend
│   ├── Account Login
│   └── API Key
├── Vercel
│   ├── Team Login
│   └── Deploy Token
└── Domain Registrar
    ├── Login Credentials
    └── Transfer Lock Code
```

---

## 🚨 Security Best Practices

### DO:
✅ Use different passwords for each service
✅ Enable 2FA everywhere
✅ Rotate API keys every 90 days
✅ Use environment variables (never commit secrets)
✅ Keep production and development separate
✅ Monitor access logs regularly
✅ Have offsite backups
✅ Document everything

### DON'T:
❌ Commit API keys to Git
❌ Share passwords via email/Slack
❌ Use personal accounts for company services
❌ Give admin access to everyone
❌ Skip 2FA setup
❌ Use same password across services
❌ Forget to lock down domain transfers

---

## 📞 Emergency Contacts & Escalation

**If Production Goes Down**:

1. Check Vercel status: https://vercel.com/status
2. Check Supabase status: https://status.supabase.com
3. Check DNS propagation: https://dnschecker.org
4. Contact: Josh (primary) → Jeff (secondary)

**If Database Issue**:
1. Check Supabase dashboard
2. Review recent migrations
3. Check error logs in Vercel
4. Restore from backup if needed

**If Domain/DNS Issue**:
1. Check domain expiration
2. Verify nameservers
3. Check DNS records
4. Wait for propagation (up to 48h)

---

## 🎓 Training Materials

### For Josh:

1. **GitHub Basics**:
   - How to review pull requests
   - How to merge to production
   - When to create branches

2. **Vercel Dashboard Tour**:
   - How to view deployments
   - How to check logs
   - How to rollback

3. **Supabase Dashboard Tour**:
   - How to view database
   - How to run SQL queries
   - How to check user accounts

4. **Domain Management**:
   - How to update DNS records
   - When to contact registrar
   - SSL certificate renewal (automatic)

---

## ✅ Final Verification

Before considering migration complete:

### Test Checklist:

- [ ] Can log in as admin at production URL
- [ ] Can log in as client at production URL
- [ ] Password reset emails arrive
- [ ] Job posting works end-to-end
- [ ] Payment processing works (test mode first!)
- [ ] Candidate upload works
- [ ] Email notifications send correctly
- [ ] All images/assets load
- [ ] Mobile responsive works
- [ ] SSL certificate is valid
- [ ] Custom domain resolves correctly
- [ ] Staging environment works
- [ ] Can deploy from main branch
- [ ] Branch protection prevents direct pushes
- [ ] All API keys are new (rotated)

---

## 📊 Timeline Estimate

**Conservative Estimate**: 3-4 weeks
**Aggressive Estimate**: 1-2 weeks

**Critical Path**:
1. GitHub org setup (1 day)
2. Repository transfer (1 day)
3. Supabase migration (3-5 days)
4. DNS changes (1 day + 48h propagation)
5. Vercel setup (2-3 days)
6. Testing (3-5 days)
7. Go-live (1 day)

**Recommended**: Do it in phases over 3-4 weeks to catch issues early.

---

## 🎯 Quick Start (If Rushed)

**Minimum Viable Setup** (can be done in 1 day):

1. Create GroundUp GitHub org
2. Transfer repo
3. Create `main` branch from current working branch
4. Set up Vercel project pointing to new repo
5. Copy all environment variables to Vercel
6. Deploy to production URL
7. Lock down access (2FA everywhere)

**Then gradually**:
- Set up branch protection
- Migrate Supabase
- Configure custom domain
- Rotate API keys
- Add monitoring

---

Need help with any specific phase? Let me know which part you want to tackle first!
