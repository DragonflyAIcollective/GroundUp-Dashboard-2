# 🔐 Quick Lockdown Checklist
## GroundUp Dashboard - Security & Organization

---

## 🚀 QUICK START (Do This First!)

### 1. GitHub Organization (30 minutes)

```
☐ Go to: github.com/organizations/plan
☐ Create organization: "GroundUpCareers" (or Josh's preferred name)
☐ Add Josh as Owner
☐ Add yourself (jeffgus) as Admin
☐ Transfer repo: DragonflyAIcollective/GroundUp-Dashboard-2 → GroundUpCareers/GroundUp-Dashboard-2
   Settings → Danger Zone → Transfer Ownership
☐ Update local remote: git remote set-url origin https://github.com/GroundUpCareers/GroundUp-Dashboard-2.git
```

### 2. Create Main Branch (15 minutes)

```bash
# In your local repository:
☐ git checkout claude/dashboard-rundown-011CV1iSWh5eJ3tn1PNRh67J
☐ git checkout -b main
☐ git push -u origin main

# On GitHub:
☐ Settings → Branches → Default branch → Change to "main"
☐ Settings → Branches → Add rule for "main"
   ☑ Require pull request before merging
   ☑ Require approvals: 1
```

### 3. Vercel Quick Setup (20 minutes)

```
☐ Go to: vercel.com/dashboard
☐ Create Team: "GroundUp Careers"
☐ Import project from: GroundUpCareers/GroundUp-Dashboard-2
☐ Copy ALL environment variables from old project
☐ Set Production Branch: main
☐ Deploy!
```

---

## 🔐 SECURITY LOCKDOWN (Critical!)

### Enable 2FA Everywhere

```
☐ GitHub (Josh's account)
☐ Supabase (organization account)
☐ Vercel (team account)
☐ Resend (account)
☐ Domain Registrar (GoDaddy/Namecheap/etc.)
```

### Rotate ALL API Keys

```
☐ Supabase Service Role Key
☐ Supabase Anon Key
☐ Resend API Key
☐ Stripe Secret Key (if going to production!)
☐ Update ALL keys in Vercel environment variables
```

### Lock Down Domain

```
☐ Enable transfer lock at registrar
☐ Enable auto-renew
☐ Enable WHOIS privacy
☐ Add Josh as primary contact
☐ Document registrar login in password manager
```

---

## 📋 SERVICE-BY-SERVICE CHECKLIST

### GitHub ✓

```
☐ Organization created
☐ Repository transferred
☐ Josh added as owner
☐ Main branch created
☐ Branch protection enabled
☐ 2FA enabled for all members
☐ Organization settings reviewed
☐ Webhooks updated (if any)
```

### Supabase ✓

```
☐ Organization created
☐ Project transferred or recreated
☐ Josh added as owner
☐ API keys rotated
☐ Environment variables updated in Vercel
☐ Database backups enabled
☐ RLS policies verified
☐ 2FA enabled
```

### Resend ✓

```
☐ Account under GroundUp ownership
☐ Domain verified: groundupcareers.com
☐ DNS records added (SPF, DKIM, DMARC)
☐ New API key generated
☐ Old key deleted
☐ Environment variable updated in Vercel
☐ Test email sent successfully
☐ 2FA enabled
```

### Vercel ✓

```
☐ Team created: "GroundUp Careers"
☐ Project imported/transferred
☐ Josh added as owner
☐ Production domain configured
☐ All environment variables set
☐ Production branch: main
☐ Deployments working
☐ SSL certificate active
☐ 2FA enabled
```

### DNS/Domain ✓

```
☐ Domain ownership confirmed
☐ Josh is primary contact
☐ Transfer lock enabled
☐ Auto-renew enabled
☐ Nameservers configured (Cloudflare or Vercel)
☐ DNS records added:
   ☐ A/CNAME for app.groundupcareers.com → Vercel
   ☐ TXT for Resend verification
   ☐ TXT for DKIM
   ☐ TXT for SPF
   ☐ TXT for DMARC (optional)
☐ SSL certificate valid
☐ Domain resolves correctly
```

---

## 🧪 TESTING CHECKLIST

### Before Going Live

```
☐ Can access production URL
☐ Admin login works (jeffgus@gmail.com)
☐ Admin login works (Josh's email)
☐ Client login works (test account)
☐ Password reset email arrives
☐ Job posting flow works
☐ Candidate upload works
☐ Payment works (test mode!)
☐ All images load
☐ Mobile responsive
☐ SSL valid (🔒 in browser)
☐ No console errors
```

### Production Payment Test

```
⚠️ IMPORTANT: Only after everything else works!

☐ Switch Stripe to LIVE mode
☐ Update VITE_STRIPE_PUBLIC_KEY in Vercel
☐ Update STRIPE_SECRET_KEY in Vercel
☐ Update STRIPE_WEBHOOK_SECRET in Vercel
☐ Configure Stripe webhook: vercel-url.com/api/stripe-webhook
☐ Test with real payment (refund after!)
```

---

## 📝 DOCUMENTATION CHECKLIST

### Password Manager Setup

```
☐ Choose password manager (1Password/LastPass)
☐ Create "GroundUp Careers" vault
☐ Store all credentials:
   ☐ GitHub org credentials
   ☐ Supabase login + API keys
   ☐ Vercel team login
   ☐ Resend login + API key
   ☐ Domain registrar
   ☐ Stripe account
☐ Share vault with Josh
☐ Store 2FA backup codes
```

### Emergency Documentation

```
☐ Create "Emergency Contacts" doc
☐ Create "How to Deploy" guide
☐ Create "How to Rollback" guide
☐ Create "Common Issues" doc
☐ Document all environment variables
☐ Store DNS configuration
☐ Create disaster recovery plan
```

---

## 👥 ACCESS CONTROL CHECKLIST

### Who Has Access to What?

#### GitHub

```
☐ Josh → Owner ✓
☐ Jeff → Admin (temporary) ✓
☐ Remove: Any unnecessary people
```

#### Supabase

```
☐ Josh → Owner ✓
☐ Jeff → Admin (can downgrade to Developer later) ✓
☐ No service accounts with Owner role
```

#### Vercel

```
☐ Josh → Owner ✓
☐ Jeff → Admin ✓
☐ Deploy bot → Member (if using CI/CD)
```

#### Resend

```
☐ Josh → Owner ✓
☐ Jeff → Admin (if needed) ✓
```

#### Domain Registrar

```
☐ Josh → Primary Owner ✓
☐ Jeff → Technical Contact (emergency only)
```

---

## ⚡ IF YOU'RE IN A RUSH (30-Minute Setup)

**Absolute minimum to get production running:**

```bash
# 1. Create GitHub org and transfer repo (5 min)
# 2. Create main branch (2 min)
git checkout claude/dashboard-rundown-011CV1iSWh5eJ3tn1PNRh67J
git checkout -b main
git push -u origin main

# 3. Set up Vercel (10 min)
# - Create team
# - Import repo
# - Copy environment variables
# - Deploy

# 4. Enable 2FA (5 min)
# - GitHub
# - Vercel
# - Supabase

# 5. Test production (8 min)
# - Try logging in
# - Test one feature
# - Check SSL
```

**Then over the next week, do:**
- Rotate API keys
- Set up DNS properly
- Add branch protection
- Complete documentation

---

## 🚨 CRITICAL SECURITY ITEMS (Do Not Skip!)

### Must Do Immediately:

```
☐ Enable 2FA on GitHub
☐ Enable 2FA on Vercel
☐ Enable 2FA on Supabase
☐ Lock down domain transfers
☐ Set strong passwords (generated, 20+ chars)
☐ Store passwords in password manager
☐ Remove any hardcoded secrets from code
☐ Verify .env files are in .gitignore
```

### Must Do Within 1 Week:

```
☐ Rotate all API keys
☐ Review all access permissions
☐ Set up branch protection rules
☐ Configure DNS properly
☐ Test disaster recovery
☐ Document everything
☐ Train Josh on basic operations
```

---

## 📊 PROGRESS TRACKER

### Phase 1: Organization (Week 1)

```
Progress: ☐☐☐☐☐ 0%

☐ GitHub org created
☐ Repo transferred
☐ Branches set up
☐ Access configured
```

### Phase 2: Services (Week 2)

```
Progress: ☐☐☐☐☐ 0%

☐ Supabase migrated
☐ Vercel configured
☐ Resend set up
☐ DNS configured
```

### Phase 3: Security (Week 3)

```
Progress: ☐☐☐☐☐ 0%

☐ 2FA everywhere
☐ API keys rotated
☐ Passwords secured
☐ Domain locked
```

### Phase 4: Production (Week 4)

```
Progress: ☐☐☐☐☐ 0%

☐ Testing complete
☐ Documentation done
☐ Training provided
☐ GO LIVE! 🚀
```

---

## 🎯 SUCCESS CRITERIA

### You're Done When:

```
✓ Josh can log into admin dashboard
✓ Domain app.groundupcareers.com works
✓ SSL certificate is valid
✓ Emails send successfully
✓ Payments process correctly
✓ All services under GroundUp ownership
✓ All accounts have 2FA
✓ All API keys rotated
✓ Branch protection prevents accidents
✓ Documentation is complete
✓ Josh knows how to deploy
✓ Emergency procedures documented
✓ Jeff can step away without issues
```

---

## 📞 NEED HELP?

If stuck on:

**GitHub**: https://docs.github.com
**Supabase**: https://supabase.com/docs
**Vercel**: https://vercel.com/docs
**DNS**: https://dnschecker.org (test propagation)

Or refer to: `GITHUB_ORGANIZATION_AND_SERVICE_LOCKDOWN.md` for detailed instructions.

---

**Print this out, check boxes as you go!** ✓
