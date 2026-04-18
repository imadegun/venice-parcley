# Database Migrations for Menu Page Content Feature

## Overview
Two migrations are required:

1. **`content` column** – Rich text/HTML for editable pages (About, Contact, Neighbourhood, How to Get Here)
2. **`map_embed` column** – Google Maps iframe embed code (Contact page)

---

## Required Migrations

### Migration 1: Add `content` Column
```sql
ALTER TABLE menu_items ADD COLUMN IF NOT EXISTS content TEXT;
```
File: `migrations/001_add_content_to_menu_items.sql`

### Migration 2: Add `map_embed` Column
```sql
ALTER TABLE menu_items ADD COLUMN IF NOT EXISTS map_embed TEXT;
```
File: `migrations/002_add_map_embed_to_menu_items.sql`

---

## How to Apply

### Option A: Supabase Dashboard (Recommended)
1. Go to https://app.supabase.com → Your Project
2. **SQL Editor** → **New Query**
3. Paste migration SQL (one at a time)
4. Click **Run**
5. Repeat for second migration

### Option B: Supabase CLI
```bash
supabase db push
```

### Option C: Combined Migration
Run both in one query:
```sql
ALTER TABLE menu_items ADD COLUMN IF NOT EXISTS content TEXT;
ALTER TABLE menu_items ADD COLUMN IF NOT EXISTS map_embed TEXT;
```

---

## Verification

Check that both columns exist:
```sql
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'menu_items'
  AND column_name IN ('content', 'map_embed');
```

Expected output:
```
 column_name | data_type
-------------+-----------
 content     | text
 map_embed   | text
```

---

## After Migrating

1. **Restart dev server** to clear schema cache:
   ```bash
   rm -rf .next
   npm run dev
   ```

2. **Test admin panel:**
   - `/admin/content/pages` → Edit Contact → Paste Google Maps embed code
   - Save and verify map appears on `/contact`

3. **Test content editing:**
   - Edit About page content
   - Save and verify on `/about`

---

## Troubleshooting

**Still getting "column not found"?**
- Wait 2–3 minutes for Supabase cloud cache to refresh
- Restart local Supabase: `supabase stop && supabase start`
- Ensure you're connected to the correct database

**Diagnostic script:**
```bash
node scripts/check-schema.js
```
(Checks if `content` column is accessible via API)

---

## Feature Summary

- **Non-editable pages filtered:** `/apartments`, `/login`, `/register`, `/admin` are hidden from the content manager
- **Map embed support:** Contact page can display a map via `map_embed` iframe HTML
- **Rich text:** All editable pages support HTML content via `content` field
- **Admin UI:** Single CRUD interface at `/admin/content/pages` for all editable pages
