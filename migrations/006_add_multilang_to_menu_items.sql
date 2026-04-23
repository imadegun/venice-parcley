-- Add multilang support for title and content
ALTER TABLE menu_items ADD COLUMN IF NOT EXISTS title JSONB;
ALTER TABLE menu_items ADD COLUMN IF NOT EXISTS content JSONB;

-- Migrate existing data
UPDATE menu_items SET title = jsonb_build_object('en', label) WHERE label IS NOT NULL;
UPDATE menu_items SET content = jsonb_build_object('en', content::text) WHERE content IS NOT NULL;

-- Drop old columns
ALTER TABLE menu_items DROP COLUMN IF EXISTS label;