-- Villa Spa Database Schema
-- Generated for Supabase PostgreSQL

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create custom types
CREATE TYPE treatment_category AS ENUM ('massage', 'facial', 'body', 'packages');
CREATE TYPE booking_status AS ENUM ('confirmed', 'cancelled', 'completed');
CREATE TYPE loyalty_point_type AS ENUM ('earned', 'redeemed');
CREATE TYPE user_role AS ENUM ('guest', 'member', 'admin');

-- Treatments table
CREATE TABLE treatments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  slug TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  category treatment_category NOT NULL,
  description TEXT NOT NULL,
  duration_minutes INTEGER NOT NULL CHECK (duration_minutes > 0),
  price_cents INTEGER NOT NULL CHECK (price_cents >= 0),
  image_url TEXT,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Therapists table
CREATE TABLE therapists (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  bio TEXT,
  image_url TEXT,
  specialties TEXT[] DEFAULT '{}',
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Treatment-Therapist many-to-many relationship
CREATE TABLE treatment_therapists (
  treatment_id UUID REFERENCES treatments(id) ON DELETE CASCADE,
  therapist_id UUID REFERENCES therapists(id) ON DELETE CASCADE,
  PRIMARY KEY (treatment_id, therapist_id)
);

-- Availability slots table
CREATE TABLE availability_slots (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  therapist_id UUID REFERENCES therapists(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  is_booked BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT now(),
  -- Ensure end time is after start time
  CONSTRAINT valid_time_range CHECK (end_time > start_time)
);

-- Bookings table
CREATE TABLE bookings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  guest_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  guest_name TEXT NOT NULL,
  guest_email TEXT NOT NULL,
  guest_phone TEXT,
  treatment_id UUID REFERENCES treatments(id) ON DELETE CASCADE,
  therapist_id UUID REFERENCES therapists(id) ON DELETE CASCADE,
  slot_id UUID REFERENCES availability_slots(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  status booking_status DEFAULT 'confirmed',
  total_cents INTEGER NOT NULL CHECK (total_cents >= 0),
  loyalty_points INTEGER DEFAULT 0 CHECK (loyalty_points >= 0),
  special_requests TEXT,
  cancellation_reason TEXT,
  cancelled_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
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
  preferred_therapist_id UUID REFERENCES therapists(id),
  notification_preferences JSONB DEFAULT '{"email": true, "sms": false}',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Indexes for performance
CREATE INDEX idx_treatments_category ON treatments(category);
CREATE INDEX idx_treatments_active ON treatments(is_active);
CREATE INDEX idx_therapists_active ON therapists(is_active);
CREATE INDEX idx_slots_therapist_date ON availability_slots(therapist_id, date);
CREATE INDEX idx_slots_booked ON availability_slots(is_booked);
CREATE INDEX idx_bookings_guest ON bookings(guest_id);
CREATE INDEX idx_bookings_date ON bookings(date);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_bookings_email ON bookings(guest_email);
CREATE INDEX idx_loyalty_user ON loyalty_points(user_id);
CREATE INDEX idx_profiles_email ON profiles(email);

-- Row Level Security (RLS) Policies

-- Enable RLS on all tables
ALTER TABLE treatments ENABLE ROW LEVEL SECURITY;
ALTER TABLE therapists ENABLE ROW LEVEL SECURITY;
ALTER TABLE treatment_therapists ENABLE ROW LEVEL SECURITY;
ALTER TABLE availability_slots ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE loyalty_points ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Treatments: Public read access
CREATE POLICY "Treatments are viewable by everyone" ON treatments
  FOR SELECT USING (is_active = true);

-- Therapists: Public read access
CREATE POLICY "Therapists are viewable by everyone" ON therapists
  FOR SELECT USING (is_active = true);

-- Treatment-Therapists: Public read access
CREATE POLICY "Treatment therapists are viewable by everyone" ON treatment_therapists
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
CREATE TRIGGER update_treatments_updated_at BEFORE UPDATE ON treatments
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

-- Sample data for development

-- Insert sample treatments
INSERT INTO treatments (slug, name, category, description, duration_minutes, price_cents, image_url) VALUES
('swedish-massage', 'Swedish Massage', 'massage', 'A classic relaxation massage using gentle, flowing strokes to ease muscle tension and promote deep relaxation.', 60, 12000, 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=400'),
('deep-tissue-massage', 'Deep Tissue Massage', 'massage', 'Focused massage targeting chronic muscle tension and knots with firm pressure to release tight muscles.', 75, 14000, 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400'),
('aromatherapy-facial', 'Aromatherapy Facial', 'facial', 'Rejuvenating facial treatment with essential oils, cleansing, exfoliation, and moisturizing for radiant skin.', 60, 10000, 'https://images.unsplash.com/photo-1616394584738-fc6e612e71b9?w=400'),
('hot-stone-massage', 'Hot Stone Massage', 'massage', 'Therapeutic massage using heated stones to melt away tension and promote deep relaxation.', 90, 16000, 'https://images.unsplash.com/photo-1596170379749-0e5b96a5d9c8?w=400'),
('body-scrub', 'Luxury Body Scrub', 'body', 'Exfoliating treatment with natural sea salts and essential oils to smooth and rejuvenate the skin.', 45, 8000, 'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?w=400'),
('relaxation-package', 'Ultimate Relaxation Package', 'packages', 'Full day of pampering including massage, facial, and body treatment for complete rejuvenation.', 180, 28000, 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=400');

-- Insert sample therapists
INSERT INTO therapists (name, bio, specialties, image_url) VALUES
('Sarah Johnson', 'Certified massage therapist with 8 years of experience specializing in relaxation techniques.', ARRAY['Swedish Massage', 'Deep Tissue'], 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400'),
('Emma Chen', 'Licensed esthetician and aromatherapist with expertise in natural skincare treatments.', ARRAY['Facials', 'Aromatherapy'], 'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=400'),
('Michael Rodriguez', 'Experienced therapist specializing in sports massage and therapeutic treatments.', ARRAY['Deep Tissue', 'Sports Massage'], 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400');

-- Link treatments to therapists
INSERT INTO treatment_therapists (treatment_id, therapist_id)
SELECT t.id, th.id FROM treatments t, therapists th
WHERE (t.slug = 'swedish-massage' AND th.name = 'Sarah Johnson')
   OR (t.slug = 'deep-tissue-massage' AND th.name IN ('Sarah Johnson', 'Michael Rodriguez'))
   OR (t.slug = 'aromatherapy-facial' AND th.name = 'Emma Chen')
   OR (t.slug = 'hot-stone-massage' AND th.name = 'Sarah Johnson')
   OR (t.slug = 'body-scrub' AND th.name = 'Emma Chen')
   OR (t.slug IN ('relaxation-package', 'swedish-massage', 'aromatherapy-facial', 'body-scrub') AND th.name IN ('Sarah Johnson', 'Emma Chen'));

-- Insert sample availability slots (next 30 days)
INSERT INTO availability_slots (therapist_id, date, start_time, end_time)
SELECT
  th.id,
  CURRENT_DATE + (n || ' days')::interval,
  (9 + (s.slot_num * 2)) || ':00:00'::time,
  (11 + (s.slot_num * 2)) || ':00:00'::time
FROM therapists th
CROSS JOIN generate_series(0, 29) n
CROSS JOIN (SELECT generate_series(0, 2) as slot_num) s
WHERE th.is_active = true
  AND EXTRACT(dow FROM CURRENT_DATE + (n || ' days')::interval) BETWEEN 1 AND 6; -- Monday to Saturday