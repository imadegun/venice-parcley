-- Migration: Change menu_items.label to menu_items.title as JSONB for multi-language support
ALTER TABLE menu_items ADD COLUMN IF NOT EXISTS title JSONB;

-- Migrate existing label data to title JSONB with 'en' key
UPDATE menu_items SET title = jsonb_build_object('en', label) WHERE label IS NOT NULL;

-- Drop the old label column
ALTER TABLE menu_items DROP COLUMN IF EXISTS label;