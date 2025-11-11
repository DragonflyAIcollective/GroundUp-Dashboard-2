-- =====================================================
-- MAKE jeffgus@gmail.com AN ADMIN
-- =====================================================
-- Run this in Supabase SQL Editor
-- =====================================================

-- Step 1: Check current role
SELECT email, full_name, role, is_active
FROM profiles
WHERE email = 'jeffgus@gmail.com';

-- Step 2: Update to admin role
UPDATE profiles
SET role = 'admin'
WHERE email = 'jeffgus@gmail.com';

-- Step 3: Verify the change
SELECT email, full_name, role, is_active
FROM profiles
WHERE email = 'jeffgus@gmail.com';

-- Step 4: View all admins
SELECT email, full_name, role, is_active, created_at
FROM profiles
WHERE role = 'admin'
ORDER BY created_at;

-- =====================================================
-- AFTER RUNNING THIS:
-- 1. Log out of the dashboard
-- 2. Log back in with jeffgus@gmail.com
-- 3. You should now see the Admin Dashboard!
-- =====================================================
