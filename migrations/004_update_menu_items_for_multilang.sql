-- Update menu_items table for multi-language content and image support
ALTER TABLE menu_items ADD COLUMN image_url TEXT;
ALTER TABLE menu_items ALTER COLUMN content TYPE JSONB USING jsonb_build_object('en', content, 'it', '') WHERE content IS NOT NULL;
ALTER TABLE menu_items ALTER COLUMN content TYPE JSONB USING '{}' WHERE content IS NULL;