# Fix Admin Roles - Quick Guide

## Check Current Roles

Run this in **Supabase SQL Editor** to see all users and their roles:

```sql
SELECT
  email,
  full_name,
  role,
  is_active,
  created_at
FROM profiles
ORDER BY created_at;
```

---

## Issue: You Need to Be Admin

If you're currently showing as `client` role but you should be an `admin`, here's how to fix it:

### Step 1: Find Your Email
Run this to see who's currently an admin:
```sql
SELECT email, full_name, role
FROM profiles
WHERE role = 'admin';
```

### Step 2: Update Your Role to Admin

Replace `YOUR_EMAIL_HERE` with your actual email address:

```sql
-- Make yourself an admin
UPDATE profiles
SET role = 'admin'
WHERE email = 'YOUR_EMAIL_HERE';
```

For example, if your email is `jeffgus@gmail.com`:
```sql
UPDATE profiles
SET role = 'admin'
WHERE email = 'jeffgus@gmail.com';
```

### Step 3: Verify the Change
```sql
SELECT email, full_name, role
FROM profiles
WHERE email = 'YOUR_EMAIL_HERE';
```

### Step 4: Log Out and Back In
After updating your role:
1. Log out of the dashboard
2. Log back in
3. You should now see the Admin Dashboard

---

## Make Multiple People Admin

You can have multiple admins! To add more:

```sql
-- Make Josh Denton an admin (if not already)
UPDATE profiles
SET role = 'admin'
WHERE email = 'josh.denton@example.com';  -- Use his actual email

-- Make yourself an admin
UPDATE profiles
SET role = 'admin'
WHERE email = 'your.email@example.com';  -- Use your actual email

-- Verify both are admins
SELECT email, full_name, role
FROM profiles
WHERE role = 'admin';
```

---

## Current Known Emails

Based on migrations and documentation:
- `jeffgus@gmail.com` - Was set as admin in migrations
- `asymmetrictrader100x@gmail.com` - Showed up in client registration email
- Josh Denton - (need to find his email in profiles)

---

## If You Don't Know Your Email

Run this to see all emails in the system:
```sql
SELECT email, full_name, role, created_at
FROM profiles
ORDER BY created_at DESC;
```

Look for your name or the email you used to sign up.

---

## Quick Fix Template

Copy this and replace the email addresses:

```sql
-- Update YOUR role to admin
UPDATE profiles
SET role = 'admin'
WHERE email = 'YOUR_EMAIL@example.com';

-- Update JOSH's role to admin (if needed)
UPDATE profiles
SET role = 'admin'
WHERE email = 'JOSH_EMAIL@example.com';

-- Verify both are admins
SELECT email, full_name, role, is_active
FROM profiles
WHERE role = 'admin';
```

---

## Need Help?

Tell me:
1. What email address you use to log in
2. What email address Josh uses to log in

And I'll give you the exact SQL commands to run!

---

## Where to Run These Commands

1. Go to https://supabase.com/dashboard
2. Select your project: **GroundUp-Dashboard-2**
3. Click **SQL Editor** (left sidebar)
4. Click **New Query**
5. Paste the SQL
6. Click **Run** (or press Ctrl+Enter)

---

**Note**: You need access to the Supabase dashboard to run these SQL commands. If you don't have access, ask whoever has the Supabase admin credentials to run these for you.
