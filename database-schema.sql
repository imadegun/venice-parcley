-- Venice Parcley Database Schema
-- Generated for Supabase PostgreSQL
-- Apartment-only booking system (transportation features removed)

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create custom types
CREATE TYPE booking_status AS ENUM ('confirmed', 'cancelled', 'completed');
CREATE TYPE user_role AS ENUM ('guest', 'member', 'admin');

-- Luxury Artistic Apartments table (PRIMARY)
CREATE TABLE apartments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  slug TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  short_description TEXT,
  max_guests INTEGER NOT NULL CHECK (max_guests > 0),
  bedrooms INTEGER NOT NULL CHECK (bedrooms >= 0),
  base_price_cents INTEGER NOT NULL CHECK (base_price_cents >= 0),
  image_url TEXT,
  gallery_images TEXT[] DEFAULT '{}',
  amenities TEXT[] DEFAULT '{}',
  location_details JSONB,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Bookings table (apartment bookings only)
CREATE TABLE bookings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  apartment_id UUID REFERENCES apartments(id) ON DELETE CASCADE,
  check_in_date DATE NOT NULL,
  check_out_date DATE NOT NULL,
  total_guests INTEGER NOT NULL CHECK (total_guests > 0),
  status booking_status DEFAULT 'confirmed',
  total_cents INTEGER NOT NULL CHECK (total_cents >= 0),
  special_requests TEXT,
  cancellation_reason TEXT,
  cancelled_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  CONSTRAINT valid_date_range CHECK (check_out_date > check_in_date)
);

-- Loyalty points table
CREATE TABLE loyalty_points (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  points INTEGER NOT NULL CHECK (points > 0),
  type loyalty_point_type NOT NULL,
  booking_id UUID REFERENCES bookings(id) ON DELETE SET NULL,
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- User profiles table (extends auth.users)
CREATE TABLE profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL,
  full_name TEXT,
  phone TEXT,
  role user_role DEFAULT 'guest',
  notification_preferences JSONB DEFAULT '{"email": true, "sms": false}',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Indexes for performance
CREATE INDEX idx_bookings_user ON bookings(user_id);
CREATE INDEX idx_bookings_apartment ON bookings(apartment_id);
CREATE INDEX idx_bookings_dates ON bookings(check_in_date, check_out_date);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_loyalty_user ON loyalty_points(user_id);
CREATE INDEX idx_profiles_email ON profiles(email);

-- Row Level Security (RLS) Policies

-- Enable RLS on all tables
ALTER TABLE apartments ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE loyalty_points ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Apartments: Public read access for active apartments
CREATE POLICY "Apartments are viewable by everyone" ON apartments
  FOR SELECT USING (is_active = true);

-- Bookings: Users can view their own bookings, admins can view all
CREATE POLICY "Users can view own bookings" ON bookings
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Admins can view all bookings" ON bookings
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

CREATE POLICY "Users can insert bookings" ON bookings
  FOR INSERT WITH CHECK (auth.uid() = user_id OR auth.uid() IS NULL);

CREATE POLICY "Users can update own bookings" ON bookings
  FOR UPDATE USING (auth.uid() = user_id);

-- Loyalty points: Users can view their own points
CREATE POLICY "Users can view own loyalty points" ON loyalty_points
  FOR SELECT USING (auth.uid() = user_id);

-- Profiles: Users can view and update their own profile
CREATE POLICY "Users can view own profile" ON profiles
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON profiles
  FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Users can insert own profile" ON profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

-- Functions and Triggers

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Add updated_at triggers
CREATE TRIGGER update_apartments_updated_at BEFORE UPDATE ON apartments
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_bookings_updated_at BEFORE UPDATE ON bookings
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON profiles
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Function to create profile on user signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name)
  VALUES (NEW.id, NEW.email, NEW.raw_user_meta_data->>'full_name');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to create profile on signup
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Function to award loyalty points on booking completion
CREATE OR REPLACE FUNCTION award_loyalty_points()
RETURNS TRIGGER AS $$
BEGIN
  -- Only award points for new confirmed bookings
  IF NEW.status = 'confirmed' AND OLD.status != 'confirmed' THEN
    INSERT INTO loyalty_points (user_id, points, type, booking_id, description)
    VALUES (
      NEW.user_id,
      FLOOR(NEW.total_cents / 100), -- 1 point per dollar spent
      'earned',
      NEW.id,
      'Points earned from booking: ' || NEW.id
    );
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to award points on booking status change
CREATE TRIGGER on_booking_confirmed
  AFTER UPDATE ON bookings
  FOR EACH ROW
  WHEN (OLD.status != 'confirmed' AND NEW.status = 'confirmed')
  EXECUTE FUNCTION award_loyalty_points();

-- Content management tables
CREATE TABLE IF NOT EXISTS content_sections (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  key TEXT NOT NULL UNIQUE CHECK (key IN ('homepage', 'about', 'contact')),
  payload JSONB NOT NULL,
  status TEXT NOT NULL DEFAULT 'draft' CHECK (status IN ('draft', 'published')),
  version INTEGER NOT NULL DEFAULT 1 CHECK (version > 0),
  created_by UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  updated_by UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS content_revisions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  section_id UUID NOT NULL REFERENCES content_sections(id) ON DELETE CASCADE,
  key TEXT NOT NULL CHECK (key IN ('homepage', 'about', 'contact')),
  payload JSONB NOT NULL,
  version INTEGER NOT NULL CHECK (version > 0),
  published_by UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  published_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_content_sections_key_status ON content_sections(key, status);
CREATE INDEX IF NOT EXISTS idx_content_revisions_section ON content_revisions(section_id, version DESC);

ALTER TABLE content_sections ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_revisions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Published content is viewable by everyone" ON content_sections
  FOR SELECT USING (status = 'published');

CREATE POLICY "Admins can manage content sections" ON content_sections
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  ) WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

CREATE POLICY "Admins can read revisions" ON content_revisions
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

CREATE TRIGGER update_content_sections_updated_at BEFORE UPDATE ON content_sections
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Menu items table for dynamic navigation
CREATE TABLE menu_items (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  label TEXT NOT NULL,
  href TEXT NOT NULL,
  is_active BOOLEAN DEFAULT true,
  sort_order INTEGER DEFAULT 0,
  content TEXT,
  map_embed TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_menu_items_active_order ON menu_items(is_active, sort_order);

ALTER TABLE menu_items ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Menu items are viewable by everyone" ON menu_items
  FOR SELECT USING (true);

CREATE POLICY "Admins can manage menu items" ON menu_items
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  ) WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

CREATE TRIGGER update_menu_items_updated_at BEFORE UPDATE ON menu_items
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Settings table for theme and site configuration
CREATE TABLE settings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  key TEXT UNIQUE NOT NULL,
  value JSONB,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE settings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Settings are viewable by everyone" ON settings
  FOR SELECT USING (true);

CREATE POLICY "Admins can manage settings" ON settings
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  ) WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

-- Sample data for development

-- Insert default menu items
INSERT INTO menu_items (label, href, is_active, sort_order) VALUES
('About', '/about', true, 1),
('Apartments', '/apartments', true, 2),
('Neighbourhood', '/neighbourhood', true, 3),
('How to get here', '/how-to-get-here', true, 4),
('Contact with map', '/contact', true, 5);

-- Insert default settings
INSERT INTO settings (key, value) VALUES
('theme_colors', '{"header_bg_left": "#003049", "header_bg_right": "#1b211a", "footer_color": "#1b211a"}');

-- -- Insert sample luxury artistic apartments
-- INSERT INTO apartments (slug, name, description, short_description, max_guests, bedrooms, base_price_cents, image_url, gallery_images, amenities, location_details) VALUES
-- ('minimalist-studio', 'Minimalist Canvas Studio', 'A serene white canvas apartment featuring floor-to-ceiling windows and minimalist Scandinavian design. Perfect for artists seeking pure creative inspiration with natural light and clean lines.', 'Serene minimalist studio with Scandinavian design and natural light', 2, 0, 25000, 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400', ARRAY['https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800', 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800'], ARRAY['WiFi', 'Coffee machine', 'Art supplies', 'Natural lighting', 'Workspace desk'], '{"address": "Downtown Art District", "coordinates": {"lat": 1.3521, "lng": 103.8198}}'),
-- ('bohemian-loft', 'Bohemian Artist Loft', 'Vibrant bohemian loft with exposed brick walls, eclectic art collections, and creative nooks. Features vintage furniture, colorful textiles, and artistic installations throughout.', 'Vibrant bohemian loft with eclectic art and creative spaces', 4, 1, 45000, 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=400', ARRAY['https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800', 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800'], ARRAY['WiFi', 'Sound system', 'Art supplies', 'Reading nook', 'Creative workspace'], '{"address": "Arts Quarter", "coordinates": {"lat": 1.2994, "lng": 103.8458}}'),
-- ('industrial-creative-suite', 'Industrial Creative Suite', 'Converted industrial space with high ceilings, concrete walls, and modern art installations. Includes dedicated art studio space and urban design elements.', 'Industrial space converted to creative suite with art studio', 3, 1, 65000, 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=400', ARRAY['https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800', 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800'], ARRAY['WiFi', 'Sound system', 'Art supplies', 'Kitchenette', 'Storage space'], '{"address": "Industrial Arts District", "coordinates": {"lat": 1.2789, "lng": 103.8412}}'),
-- ('artist-residence-penthouse', 'Artist Residence Penthouse', 'Luxurious penthouse apartment designed for artists with panoramic city views, private rooftop terrace, and professional-grade art studio with natural northern light.', 'Luxurious penthouse with panoramic views and professional art studio', 2, 2, 95000, 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=400', ARRAY['https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800', 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800'], ARRAY['WiFi', 'Sound system', 'Art supplies', 'Terrace access', 'Premium appliances'], '{"address": "Luxury Arts Tower", "coordinates": {"lat": 1.2834, "lng": 103.8607}}');

