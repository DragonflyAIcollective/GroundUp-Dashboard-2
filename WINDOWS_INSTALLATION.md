# 💻 Windows Installation Guide - Supabase CLI

If you're on Windows and don't have Scoop, here are alternative methods to install the Supabase CLI.

---

## Method 1: Direct Binary Download (Recommended)

### Step 1: Download the Binary

1. **Visit:** https://github.com/supabase/cli/releases/latest
2. **Download:** `supabase_windows_amd64.zip`
3. **Extract** the zip file to a folder (e.g., `C:\supabase`)

### Step 2: Add to PATH

**Option A: Via GUI**
1. Press `Win + X` and select "System"
2. Click "Advanced system settings" on the right
3. Click "Environment Variables"
4. Under "System variables", find and select "Path"
5. Click "Edit"
6. Click "New"
7. Add the path where you extracted supabase (e.g., `C:\supabase`)
8. Click "OK" on all windows

**Option B: Via PowerShell (as Administrator)**
```powershell
# Add Supabase to PATH (replace with your actual path)
$supabasePath = "C:\supabase"
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$supabasePath", "Machine")
```

### Step 3: Verify Installation

Close and reopen PowerShell, then run:
```powershell
supabase --version
```

You should see the version number!

---

## Method 2: Install Scoop First (Then Supabase)

If you'd like to use Scoop (recommended for managing dev tools):

### Step 1: Install Scoop

Open PowerShell (as regular user, NOT administrator) and run:

```powershell
# Set execution policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Install Scoop
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

### Step 2: Install Supabase CLI

```powershell
scoop bucket add supabase https://github.com/supabase/scoop-bucket.git
scoop install supabase
```

### Step 3: Verify

```powershell
supabase --version
```

---

## Method 3: Use WSL (Windows Subsystem for Linux)

If you have WSL installed, you can use the Linux installation method:

### Step 1: Open WSL Terminal

```bash
# Update package lists
sudo apt update

# Download and install Supabase CLI
wget https://github.com/supabase/cli/releases/download/v2.54.11/supabase_2.54.11_linux_amd64.deb
sudo dpkg -i supabase_2.54.11_linux_amd64.deb
```

### Step 2: Verify

```bash
supabase --version
```

### Step 3: Navigate to Your Project

```bash
# Your Windows files are accessible at /mnt/c/
cd /mnt/c/Users/YourUsername/path/to/GroundUp-Dashboard
```

---

## Method 4: Use npm/npx (No Installation)

You can use Supabase CLI via npx without installing it:

```powershell
# Run commands via npx
npx supabase@latest --version

# Link project
npx supabase@latest link --project-ref wzlqbrglftrkxrfztcqd

# Deploy migrations
npx supabase@latest db push

# Deploy functions
npx supabase@latest functions deploy send-email-alert
```

**Note:** This will be slower as it downloads the CLI each time, but requires no installation.

---

## Troubleshooting

### Issue: "supabase is not recognized"

**Solution 1:** Restart PowerShell/Terminal after installation

**Solution 2:** Verify PATH is set correctly
```powershell
$env:Path -split ';' | Select-String supabase
```

**Solution 3:** Use full path
```powershell
C:\supabase\supabase.exe --version
```

### Issue: "Execution policy error"

**Solution:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Issue: Permission denied

**Solution:** Run PowerShell as Administrator for system-wide installation

---

## Quick Reference

### After Installation

```powershell
# Navigate to project
cd C:\Users\YourUsername\path\to\GroundUp-Dashboard

# Link to Supabase
supabase link --project-ref wzlqbrglftrkxrfztcqd

# Deploy migrations (use Git Bash or convert script)
bash deploy-migrations.sh

# OR manually:
supabase db push

# Set secrets
supabase secrets set RESEND_API_KEY=re_your_key

# Deploy functions
supabase functions deploy send-email-alert
```

---

## Using Git Bash (Recommended for Scripts)

Our deployment scripts are bash scripts. To use them on Windows:

### Option 1: Install Git Bash

1. Download Git for Windows: https://git-scm.com/download/win
2. Install with default options
3. Open "Git Bash" from Start menu
4. Navigate to project and run scripts:

```bash
cd /c/Users/YourUsername/path/to/GroundUp-Dashboard
./deploy-migrations.sh
./deploy-functions.sh
./setup-secrets.sh
```

### Option 2: Use PowerShell Equivalents

I can create PowerShell versions of the scripts if needed!

---

## Recommended Setup for Windows Developers

For the best experience:

1. **Install Git Bash** (for running bash scripts)
2. **Install Supabase CLI** (Method 1: Direct Binary)
3. **Use Git Bash** for deployment commands
4. **Use PowerShell or VSCode** for general development

This gives you the flexibility to use both Windows and Unix-style commands.

---

## Need Help?

If you're still having issues:

1. Check which method you prefer (Direct Binary, Scoop, WSL, or npx)
2. Follow the specific steps for that method
3. Verify installation with `supabase --version`
4. If stuck, we can create PowerShell versions of the deployment scripts

Let me know which method you'd like to use and I can provide more specific guidance!
