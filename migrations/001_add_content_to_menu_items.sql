-- Migration: Add content column to menu_items table
-- Date: 2026-04-18
-- Description: Add rich text content support for menu-driven pages

ALTER TABLE menu_items ADD COLUMN IF NOT EXISTS content TEXT;

-- Update existing menu items to have NULL content (default)
-- This is safe as content is optional

COMMENT ON COLUMN menu_items.content IS 'Rich text/HTML content for the page associated with this menu item';
