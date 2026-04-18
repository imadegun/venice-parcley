-- Venice Parcley Database Schema
-- Generated for Supabase PostgreSQL

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create custom types
CREATE TYPE apartment_category AS ENUM ('artistic_studio', 'design_loft', 'creative_suite', 'artist_residence');
CREATE TYPE transport_category AS ENUM ('cars', 'taxis', 'chauffeurs', 'airport_transfers');
CREATE TYPE booking_status AS ENUM ('confirmed', 'cancelled', 'completed');
CREATE TYPE booking_type AS ENUM ('apartment', 'transportation');
CREATE TYPE loyalty_point_type AS ENUM ('earned', 'redeemed');
CREATE TYPE user_role AS ENUM ('guest', 'member', 'admin');

-- Luxury Artistic Apartments table (PRIMARY)
CREATE TABLE apartments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  slug TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  category apartment_category NOT NULL,
  description TEXT NOT NULL,
  short_description TEXT,
  max_guests INTEGER NOT NULL CHECK (max_guests > 0),
  bedrooms INTEGER NOT NULL CHECK (bedrooms >= 0),
  bathrooms DECIMAL(3,1) NOT NULL CHECK (bathrooms > 0),
  size_sqm INTEGER NOT NULL CHECK (size_sqm > 0),
  base_price_cents INTEGER NOT NULL CHECK (base_price_cents >= 0),
  image_url TEXT,
  gallery_images TEXT[] DEFAULT '{}',
  amenities TEXT[] DEFAULT '{}',
  location_details JSONB,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Transportation services table (SECONDARY)
CREATE TABLE transportation_services (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  slug TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  category transport_category NOT NULL,
  description TEXT NOT NULL,
  capacity INTEGER NOT NULL CHECK (capacity > 0),
  price_cents INTEGER NOT NULL CHECK (price_cents >= 0),
  image_url TEXT,
  features TEXT[] DEFAULT '{}',
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Drivers table
CREATE TABLE drivers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  bio TEXT,
  image_url TEXT,
  specialties TEXT[] DEFAULT '{}',
  license_number TEXT,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Service-Driver many-to-many relationship
CREATE TABLE service_drivers (
  service_id UUID REFERENCES transportation_services(id) ON DELETE CASCADE,
  driver_id UUID REFERENCES drivers(id) ON DELETE CASCADE,
  PRIMARY KEY (service_id, driver_id)
);

-- Availability slots table
CREATE TABLE availability_slots (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  driver_id UUID REFERENCES drivers(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  is_booked BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT now(),
  -- Ensure end time is after start time
  CONSTRAINT valid_time_range CHECK (end_time > start_time)
);

-- Bookings table (supports both apartments and transportation)
CREATE TABLE bookings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  booking_type booking_type NOT NULL,
  guest_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  guest_name TEXT NOT NULL,
  guest_email TEXT NOT NULL,
  guest_phone TEXT,

  -- Apartment booking fields
  apartment_id UUID REFERENCES apartments(id) ON DELETE CASCADE,
  check_in_date DATE,
  check_out_date DATE,
  num_guests INTEGER CHECK (num_guests > 0),

  -- Transportation booking fields
  service_id UUID REFERENCES transportation_services(id) ON DELETE CASCADE,
  driver_id UUID REFERENCES drivers(id) ON DELETE CASCADE,
  slot_id UUID REFERENCES availability_slots(id) ON DELETE CASCADE,
  booking_date DATE,
  start_time TIME,
  end_time TIME,

  -- Common fields
  status booking_status DEFAULT 'confirmed',
  total_cents INTEGER NOT NULL CHECK (total_cents >= 0),
  loyalty_points INTEGER DEFAULT 0 CHECK (loyalty_points >= 0),
  special_requests TEXT,
  concierge_notes TEXT,
  cancellation_reason TEXT,
  cancelled_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),

  -- Constraints
  CONSTRAINT valid_apartment_booking CHECK (
    (booking_type = 'apartment' AND apartment_id IS NOT NULL AND check_in_date IS NOT NULL AND check_out_date IS NOT NULL) OR
    (booking_type = 'transportation' AND service_id IS NOT NULL AND booking_date IS NOT NULL AND start_time IS NOT NULL)
  ),
  CONSTRAINT valid_date_range CHECK (check_out_date > check_in_date OR check_out_date IS NULL)
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
  preferred_driver_id UUID REFERENCES drivers(id),
  notification_preferences JSONB DEFAULT '{"email": true, "sms": false}',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Indexes for performance
CREATE INDEX idx_transportation_services_category ON transportation_services(category);
CREATE INDEX idx_transportation_services_active ON transportation_services(is_active);
CREATE INDEX idx_drivers_active ON drivers(is_active);
CREATE INDEX idx_slots_driver_date ON availability_slots(driver_id, date);
CREATE INDEX idx_slots_booked ON availability_slots(is_booked);
CREATE INDEX idx_bookings_guest ON bookings(guest_id);
CREATE INDEX idx_bookings_transport_date ON bookings(booking_date);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_bookings_email ON bookings(guest_email);
CREATE INDEX idx_loyalty_user ON loyalty_points(user_id);
CREATE INDEX idx_profiles_email ON profiles(email);

-- Row Level Security (RLS) Policies

-- Enable RLS on all tables
ALTER TABLE apartments ENABLE ROW LEVEL SECURITY;
ALTER TABLE transportation_services ENABLE ROW LEVEL SECURITY;
ALTER TABLE drivers ENABLE ROW LEVEL SECURITY;
ALTER TABLE service_drivers ENABLE ROW LEVEL SECURITY;
ALTER TABLE availability_slots ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE loyalty_points ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Apartments: Public read access
CREATE POLICY "Apartments are viewable by everyone" ON apartments
  FOR SELECT USING (is_active = true);

-- Transportation services: Public read access
CREATE POLICY "Transportation services are viewable by everyone" ON transportation_services
  FOR SELECT USING (is_active = true);

-- Drivers: Public read access
CREATE POLICY "Drivers are viewable by everyone" ON drivers
  FOR SELECT USING (is_active = true);

-- Service-Drivers mapping: Public read access
CREATE POLICY "Service drivers are viewable by everyone" ON service_drivers
  FOR SELECT USING (true);

-- Availability slots: Public read access
CREATE POLICY "Availability slots are viewable by everyone" ON availability_slots
  FOR SELECT USING (true);

-- Bookings: Users can view their own bookings, admins can view all
CREATE POLICY "Users can view own bookings" ON bookings
  FOR SELECT USING (auth.uid() = guest_id);

CREATE POLICY "Admins can view all bookings" ON bookings
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

CREATE POLICY "Users can insert bookings" ON bookings
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Users can update own bookings" ON bookings
  FOR UPDATE USING (auth.uid() = guest_id);

-- Loyalty points: Users can view their own points
CREATE POLICY "Users can view own loyalty points" ON loyalty_points
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "System can insert loyalty points" ON loyalty_points
  FOR INSERT WITH CHECK (true);

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

CREATE TRIGGER update_transportation_services_updated_at BEFORE UPDATE ON transportation_services
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
      NEW.guest_id,
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
  content TEXT, -- Rich text/HTML content for page associated with this menu item
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
('theme_colors', '{"header_bg_left": "#10223f", "header_bg_right": "#7c3aed", "footer_color": "#10223f"}');

-- Insert sample luxury artistic apartments
INSERT INTO apartments (slug, name, category, description, short_description, max_guests, bedrooms, bathrooms, size_sqm, base_price_cents, image_url, gallery_images, amenities, location_details) VALUES
('minimalist-studio', 'Minimalist Canvas Studio', 'artistic_studio', 'A serene white canvas apartment featuring floor-to-ceiling windows and minimalist Scandinavian design. Perfect for artists seeking pure creative inspiration with natural light and clean lines.', 'Serene minimalist studio with Scandinavian design and natural light', 2, 0, 1.0, 45, 25000, 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400', ARRAY['https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800', 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800'], ARRAY['WiFi', 'Coffee machine', 'Art supplies', 'Natural lighting', 'Workspace desk'], '{"address": "Downtown Art District", "coordinates": {"lat": 1.3521, "lng": 103.8198}}'),
('bohemian-loft', 'Bohemian Artist Loft', 'design_loft', 'Vibrant bohemian loft with exposed brick walls, eclectic art collections, and creative nooks. Features vintage furniture, colorful textiles, and artistic installations throughout.', 'Vibrant bohemian loft with eclectic art and creative spaces', 4, 1, 1.5, 85, 45000, 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=400', ARRAY['https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800', 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800'], ARRAY['WiFi', 'Sound system', 'Art supplies', 'Reading nook', 'Creative workspace'], '{"address": "Arts Quarter", "coordinates": {"lat": 1.2994, "lng": 103.8458}}'),
('industrial-creative-suite', 'Industrial Creative Suite', 'creative_suite', 'Converted industrial space with high ceilings, concrete walls, and modern art installations. Includes dedicated art studio space and urban design elements.', 'Industrial space converted to creative suite with art studio', 3, 1, 2.0, 120, 65000, 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=400', ARRAY['https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800', 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800'], ARRAY['WiFi', 'Sound system', 'Art supplies', 'Kitchenette', 'Storage space'], '{"address": "Industrial Arts District", "coordinates": {"lat": 1.2789, "lng": 103.8412}}'),
('artist-residence-penthouse', 'Artist Residence Penthouse', 'artist_residence', 'Luxurious penthouse apartment designed for artists with panoramic city views, private rooftop terrace, and professional-grade art studio with natural northern light.', 'Luxurious penthouse with panoramic views and professional art studio', 2, 2, 2.5, 180, 95000, 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=400', ARRAY['https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800', 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800'], ARRAY['WiFi', 'Sound system', 'Art supplies', 'Terrace access', 'Premium appliances'], '{"address": "Luxury Arts Tower", "coordinates": {"lat": 1.2834, "lng": 103.8607}}');

-- Insert sample transportation services (supporting services)
INSERT INTO transportation_services (slug, name, category, description, capacity, price_cents, image_url, features) VALUES
('luxury-sedan', 'Luxury Sedan', 'cars', 'Premium sedan with leather interior, perfect for business travel or special occasions.', 4, 25000, 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=400', ARRAY['Leather Seats', 'WiFi', 'Refreshments', 'Professional Driver']),
('executive-suv', 'Executive SUV', 'cars', 'Spacious SUV ideal for families or groups needing extra luggage space.', 7, 35000, 'https://images.unsplash.com/photo-1549399735-cef2e2c3f638?w=400', ARRAY['Extra Space', 'Premium Audio', 'Tinted Windows', 'GPS Navigation']),
('premium-taxi', 'Premium Taxi', 'taxis', 'Comfortable taxi service with modern vehicles and experienced drivers.', 4, 15000, 'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=400', ARRAY['Metered Rates', 'Credit Card', 'Air Conditioning', 'Local Knowledge']),
('private-chauffeur', 'Private Chauffeur', 'chauffeurs', 'Personal chauffeur service with luxury vehicle and dedicated professional driver.', 4, 45000, 'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=400', ARRAY['Dedicated Driver', 'Luxury Vehicle', '24/7 Service', 'Flexible Scheduling']),
('airport-transfer', 'Airport Transfer', 'airport_transfers', 'Reliable airport transfer service with flight tracking and meet & greet.', 4, 30000, 'https://images.unsplash.com/photo-1436491865332-7a61a109cc05?w=400', ARRAY['Flight Tracking', 'Meet & Greet', 'Luggage Assistance', 'On-time Guarantee']);

-- Insert sample drivers
INSERT INTO drivers (name, bio, specialties, license_number, image_url) VALUES
('Marcus Chen', 'Professional chauffeur with 10 years experience driving luxury vehicles and VIP clients.', ARRAY['Luxury Cars', 'Airport Transfers', 'Executive Transport'], 'DL123456789', 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400'),
('Sarah Williams', 'Experienced driver specializing in safe and comfortable transportation for families and business travelers.', ARRAY['SUV Transport', 'Family Travel', 'Business Transport'], 'DL987654321', 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=400'),
('David Rodriguez', 'Certified chauffeur with expertise in airport transfers and long-distance travel.', ARRAY['Airport Transfers', 'Long Distance', 'VIP Service'], 'DL456789123', 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400');

-- Link services to drivers
INSERT INTO service_drivers (service_id, driver_id)
SELECT s.id, d.id FROM transportation_services s, drivers d
WHERE (s.slug = 'luxury-sedan' AND d.name = 'Marcus Chen')
   OR (s.slug = 'executive-suv' AND d.name = 'Sarah Williams')
   OR (s.slug = 'premium-taxi' AND d.name IN ('Marcus Chen', 'David Rodriguez'))
   OR (s.slug = 'private-chauffeur' AND d.name = 'Marcus Chen')
   OR (s.slug = 'airport-transfer' AND d.name = 'David Rodriguez');

-- Insert sample availability slots (next 30 days)
INSERT INTO availability_slots (driver_id, date, start_time, end_time)
SELECT
  dr.id,
  CURRENT_DATE + (n || ' days')::interval,
  make_time(9 + (s.slot_num * 2), 0, 0),
  make_time(11 + (s.slot_num * 2), 0, 0)
FROM drivers dr
CROSS JOIN generate_series(0, 29) n
CROSS JOIN (SELECT generate_series(0, 2) as slot_num) s
WHERE dr.is_active = true
  AND EXTRACT(dow FROM CURRENT_DATE + (n || ' days')::interval) BETWEEN 1 AND 6; -- Monday to Saturday
