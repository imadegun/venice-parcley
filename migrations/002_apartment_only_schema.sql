-- Migration to reset database to apartment-only schema
-- This script drops transportation/driver tables and removes unnecessary apartment columns

-- 1. Drop booking-related tables that depend on old enums (order matters due to FK constraints)
DROP TABLE IF EXISTS loyalty_points CASCADE;
DROP TABLE IF EXISTS bookings CASCADE;

-- 2. Drop old transportation/driver tables if they exist
DROP TABLE IF EXISTS availability_slots CASCADE;
DROP TABLE IF EXISTS service_drivers CASCADE;
DROP TABLE IF EXISTS drivers CASCADE;
DROP TABLE IF EXISTS transportation_services CASCADE;

-- 3. Remove old columns from apartments if they exist
ALTER TABLE apartments DROP COLUMN IF EXISTS category;
ALTER TABLE apartments DROP COLUMN IF EXISTS bathrooms;
ALTER TABLE apartments DROP COLUMN IF EXISTS size_sqm;

-- 4. Drop old enums if they exist
DROP TYPE IF EXISTS apartment_category;
DROP TYPE IF EXISTS transport_category;
DROP TYPE IF EXISTS booking_type;

-- 5. Ensure we have the correct enums
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'booking_status') THEN
    CREATE TYPE booking_status AS ENUM ('confirmed', 'cancelled', 'completed');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'user_role') THEN
    CREATE TYPE user_role AS ENUM ('guest', 'member', 'admin');
  END IF;
END $$;

-- 5. Clean existing data (optional - comment out if you want to keep existing apartment data)
-- TRUNCATE TABLE bookings CASCADE;
-- TRUNCATE TABLE apartments CASCADE;
-- TRUNCATE TABLE loyalty_points CASCADE;
-- TRUNCATE TABLE profiles CASCADE;

-- 6. Insert sample apartments if table is empty (adjust as needed)
-- INSERT INTO apartments (slug, name, description, short_description, max_guests, bedrooms, base_price_cents, image_url, gallery_images, amenities, location_details)
-- SELECT 
--   'minimalist-studio', 
--   'Minimalist Canvas Studio', 
--   'A serene white canvas apartment featuring floor-to-ceiling windows and minimalist Scandinavian design. Perfect for artists seeking pure creative inspiration with natural light and clean lines.', 
--   'Serene minimalist studio with Scandinavian design and natural light', 
--   2, 0, 25000, 
--   'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400', 
--   ARRAY['https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800', 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800'], 
--   ARRAY['WiFi', 'Coffee machine', 'Art supplies', 'Natural lighting', 'Workspace desk'], 
--   '{"address": "Downtown Art District", "coordinates": {"lat": 1.3521, "lng": 103.8198}}'
-- WHERE NOT EXISTS (SELECT 1 FROM apartments LIMIT 1);

-- INSERT INTO apartments (slug, name, description, short_description, max_guests, bedrooms, base_price_cents, image_url, gallery_images, amenities, location_details)
-- SELECT 
--   'bohemian-loft', 
--   'Bohemian Artist Loft', 
--   'Vibrant bohemian loft with exposed brick walls, eclectic art collections, and creative nooks. Features vintage furniture, colorful textiles, and artistic installations throughout.', 
--   'Vibrant bohemian loft with eclectic art and creative spaces', 
--   4, 1, 45000, 
--   'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=400', 
--   ARRAY['https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800', 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800'], 
--   ARRAY['WiFi', 'Sound system', 'Art supplies', 'Reading nook', 'Creative workspace'], 
--   '{"address": "Arts Quarter", "coordinates": {"lat": 1.2994, "lng": 103.8458}}'
-- WHERE NOT EXISTS (SELECT 1 FROM apartments WHERE slug = 'bohemian-loft');

-- INSERT INTO apartments (slug, name, description, short_description, max_guests, bedrooms, base_price_cents, image_url, gallery_images, amenities, location_details)
-- SELECT 
--   'industrial-creative-suite', 
--   'Industrial Creative Suite', 
--   'Converted industrial space with high ceilings, concrete walls, and modern art installations. Includes dedicated art studio space and urban design elements.', 
--   'Industrial space converted to creative suite with art studio', 
--   3, 1, 65000, 
--   'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=400', 
--   ARRAY['https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800', 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800'], 
--   ARRAY['WiFi', 'Sound system', 'Art supplies', 'Kitchenette', 'Storage space'], 
--   '{"address": "Industrial Arts District", "coordinates": {"lat": 1.2789, "lng": 103.8412}}'
-- WHERE NOT EXISTS (SELECT 1 FROM apartments WHERE slug = 'industrial-creative-suite');

-- INSERT INTO apartments (slug, name, description, short_description, max_guests, bedrooms, base_price_cents, image_url, gallery_images, amenities, location_details)
-- SELECT 
--   'artist-residence-penthouse', 
--   'Artist Residence Penthouse', 
--   'Luxurious penthouse apartment designed for artists with panoramic city views, private rooftop terrace, and professional-grade art studio with natural northern light.', 
--   'Luxurious penthouse with panoramic views and professional art studio', 
--   2, 2, 95000, 
--   'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=400', 
--   ARRAY['https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800', 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800'], 
--   ARRAY['WiFi', 'Sound system', 'Art supplies', 'Terrace access', 'Premium appliances'], 
--   '{"address": "Luxury Arts Tower", "coordinates": {"lat": 1.2834, "lng": 103.8607}}'
-- WHERE NOT EXISTS (SELECT 1 FROM apartments WHERE slug = 'artist-residence-penthouse');
