# Farmington Country Club - Supabase Migration Guide

## Overview

This guide walks you through migrating the FCC website from Google Sheets to Supabase.

---

## Step 1: Set Up Supabase Project

1. Go to your Supabase dashboard
2. Click **New Project**
3. Settings:
   - Name: `farmington-cc`
   - Database Password: Generate and **save this**
   - Region: **East US** (us-east-1)
4. Click **Create Project** (takes ~2 minutes)

### Get Your API Credentials

Once the project is ready:
1. Go to **Settings** → **API**
2. Copy these values:
   - **Project URL**: `https://xxxxxxxx.supabase.co`
   - **anon/public key**: `eyJhbGc...` (the long one)

---

## Step 2: Create Database Tables

1. In Supabase, go to **SQL Editor**
2. Click **New Query**
3. Paste the entire contents of `supabase-schema.sql`
4. Click **Run**

This creates all 5 tables with sample data:
- `announcements`
- `scorecard`
- `rates`
- `leagues`
- `site_settings`

### Verify Tables

Go to **Table Editor** and confirm you see all 5 tables with data.

---

## Step 3: Update index.html

Open `index.html` and make these changes:

### A. Add Supabase Script (in `<head>`)

Find this line (around line 10):
```html
<link href="https://fonts.googleapis.com/css2?family=..." rel="stylesheet">
```

Add this AFTER it:
```html
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
```

### B. Replace the JavaScript Section

Find this section (around line 2852-2862):
```javascript
// =============================================
// GOOGLE SHEETS INTEGRATION
// =============================================
const SHEETS = {
    announcement: 'https://docs.google.com/spreadsheets/...',
    ...
};
```

Delete everything from that comment down to the closing `</script>` tag (around line 3411).

Replace with the contents of `supabase-integration.js`.

### C. Add Your Credentials

In the new JavaScript, find these lines:
```javascript
const SUPABASE_URL = 'https://YOUR_PROJECT_ID.supabase.co';
const SUPABASE_ANON_KEY = 'YOUR_ANON_KEY';
```

Replace with your actual values from Step 1.

---

## Step 4: Create GitHub Repository

1. Go to GitHub → **New Repository**
2. Settings:
   - Name: `farmington-cc`
   - Private: Yes
   - Initialize with README: Yes
3. Create repository

### Upload Files

Option A - GitHub Web UI:
1. Click **Add file** → **Upload files**
2. Drag all site files
3. Commit

Option B - Git command line:
```bash
git clone https://github.com/YOUR_USERNAME/farmington-cc.git
cd farmington-cc
# Copy all site files here
git add .
git commit -m "Initial FCC website with Supabase"
git push
```

---

## Step 5: Connect Netlify to GitHub

1. In Netlify dashboard, click **Add new site** → **Import an existing project**
2. Choose **GitHub**
3. Select your `farmington-cc` repository
4. Deploy settings:
   - Build command: (leave blank)
   - Publish directory: `/` or `.`
5. Click **Deploy**

### Update Domain (Optional)

If you have a custom domain:
1. Go to **Site settings** → **Domain management**
2. Add your domain
3. Update DNS at your registrar

---

## Step 6: Test Everything

Visit your Netlify URL and verify:
- [ ] Announcement banner shows
- [ ] Scorecard modal works
- [ ] Rates display correctly
- [ ] Leagues section populates
- [ ] All navigation works

---

## Managing Content

### Edit Announcements
1. Supabase → Table Editor → `announcements`
2. Edit the `message` field
3. Toggle `active` to show/hide

### Update Rates
1. Supabase → Table Editor → `rates`
2. Edit prices, add/remove rows
3. Change `rates_year` in `site_settings`

### Edit Leagues
1. Supabase → Table Editor → `leagues`
2. Update contact info, descriptions
3. Set `active` to false to hide a league

### Toggle Membership Applications
1. Supabase → `site_settings`
2. Find `membership_open`
3. Set value to `true` or `false`

---

## File Structure

```
farmington-cc/
├── index.html              # Main page (with Supabase integration)
├── mens-league-2025.html   # Men's league standings
├── membership-application.html
├── membership-thank-you.html
├── tournament-bible.html
├── FCC-tree-gold.png       # Logo
├── FCC-tree-gold-favicon.png
├── netlify.toml            # Netlify config
├── images/
│   └── nature1-9.jpg       # Background images
└── PDFs/
    ├── TournamentBible-2025.pdf
    └── 2025MembershipApplicationForm.pdf
```

---

## Troubleshooting

### Data Not Loading
- Check browser console for errors
- Verify Supabase URL and key are correct
- Confirm RLS policies allow public read

### Scorecard Empty
- Check `scorecard` table has 9 rows
- Verify hole numbers 1-9

### Rates Not Showing
- Confirm `category` values are exactly: `membership`, `greens`, `cart`

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| FCC-v247 | Feb 2026 | Migrated to Supabase |
| FCC-v246 | Jan 2026 | Google Sheets version |
