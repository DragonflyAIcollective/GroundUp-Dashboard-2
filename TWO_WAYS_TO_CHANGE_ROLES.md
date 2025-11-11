# Two Ways to Change User Roles (Admin vs Client)

## Method 1: Visual/Manual Way (NO SQL!) ✅ EASIEST

### Step-by-Step with Supabase Table Editor:

1. **Go to Supabase Dashboard**
   - Visit: https://supabase.com/dashboard
   - Select your project: **GroundUp-Dashboard-2**

2. **Open Table Editor**
   - Click **Table Editor** in the left sidebar (NOT "SQL Editor")
   - Click on the **profiles** table

3. **Find the User**
   - Look through the rows to find the email address (e.g., `jeffgus@gmail.com`)
   - Or use the search/filter at the top to find the user

4. **Click on the "role" Cell**
   - Find the row with your email
   - Click on the **role** column cell
   - A dropdown will appear with options:
     - `admin`
     - `client`
     - `user`

5. **Select "admin"**
   - Choose `admin` from the dropdown
   - The change is saved automatically! ✅

6. **Log Out and Back In**
   - Log out of GroundUp Dashboard
   - Log back in
   - You now have admin access!

---

## Method 2: SQL Way (What We Discussed Before)

### In SQL Editor:

```sql
UPDATE profiles
SET role = 'admin'
WHERE email = 'jeffgus@gmail.com';
```

---

## Comparison

| Method | Pros | Cons |
|--------|------|------|
| **Table Editor (UI)** | ✅ Visual, easy to see all users<br>✅ Point and click<br>✅ No SQL knowledge needed<br>✅ Can edit multiple fields | ❌ Need to scroll to find user<br>❌ One at a time |
| **SQL Editor** | ✅ Fast for multiple updates<br>✅ Can update many at once<br>✅ Can copy/paste commands | ❌ Need to know SQL<br>❌ Can't see other data easily |

---

## Screenshots/Visual Guide

### Table Editor Path:
```
Supabase Dashboard
  └── Table Editor (left sidebar)
      └── profiles (table list)
          └── Find your email row
              └── Click "role" cell
                  └── Select "admin" from dropdown
                      └── Done! ✅
```

### What You'll See in Table Editor:

The profiles table has these columns:
- `id` (UUID)
- `user_id` (UUID)
- `email` ← Find your email here
- `full_name`
- **`role`** ← Click this cell to change it!
- `is_active`
- `created_at`
- `updated_at`

---

## Both Methods Work!

Choose whichever is easier for you:
- **Prefer clicking?** → Use Table Editor (Method 1)
- **Prefer commands?** → Use SQL Editor (Method 2)

Both accomplish the same thing - updating the `role` field in the `profiles` table.

---

## Future Enhancement

Right now, there's **NO way to change roles from within the GroundUp Dashboard itself** - you must use Supabase's interface (either Table Editor or SQL Editor).

A future feature could add:
- Admin Settings page
- "Manage Users" section
- Promote/demote users from within the app
- Visual list of all users with role toggles

But for now, you need to go through Supabase Dashboard (either way works!).

---

## Important Note

After changing the role using **either method**:
1. ✅ The user MUST log out
2. ✅ The user MUST log back in
3. ✅ Then they'll see their new role's dashboard

The role is checked when you log in, so you need to refresh your session.

---

## Quick Reference

**To make jeffgus@gmail.com an admin:**

### Option A (Visual - No SQL):
Supabase → Table Editor → profiles → Find jeffgus@gmail.com row → Click "role" cell → Select "admin"

### Option B (SQL):
```sql
UPDATE profiles SET role = 'admin' WHERE email = 'jeffgus@gmail.com';
```

Both work! Pick your preference! 🎯
