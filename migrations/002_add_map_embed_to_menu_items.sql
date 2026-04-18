-- Migration: Add map_embed column to menu_items table
-- Date: 2026-04-18
-- Description: Add support for location map embed code (used primarily on Contact page)

ALTER TABLE menu_items ADD COLUMN IF NOT EXISTS map_embed TEXT;

COMMENT ON COLUMN menu_items.map_embed IS 'HTML iframe embed code for location map (e.g., Google Maps embed)';
