# Farmington Country Club Website

**Est. 1924 | Farmington, NH**

A nine-hole golf course on the banks of the Cocheco River.

## Tech Stack

- **Hosting:** Netlify
- **Database:** Supabase (PostgreSQL)
- **Version Control:** GitHub

## Setup

See `MIGRATION-GUIDE.md` for complete setup instructions.

### Quick Start

1. Create Supabase project → Run `supabase-schema.sql`
2. Update `index.html` with your Supabase credentials
3. Push to GitHub → Connect to Netlify

## File Structure

```
├── index.html                 # Main page
├── mens-league-2025.html      # Men's league standings
├── membership-application.html
├── membership-thank-you.html
├── tournament-bible.html
├── netlify.toml               # Netlify config
├── FCC-tree-gold.png          # Logo
├── FCC-tree-gold-favicon.png
├── images/                    # Background photos
└── PDFs/                      # Downloadable documents
```

## Supabase Tables

| Table | Purpose |
|-------|---------|
| `announcements` | Banner messages |
| `scorecard` | Course scorecard data |
| `rates` | Membership & greens fees |
| `leagues` | League information |
| `site_settings` | Site configuration |

## Version

**FCC-v247** - February 2026 (Supabase migration)

---

*100 Years of Golf Excellence*
