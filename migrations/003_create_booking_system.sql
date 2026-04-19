-- Migration to create proper booking system tables
-- This creates the bookings table that matches the API expectations

-- Drop existing tables if they exist (from previous migrations)
DROP TABLE IF EXISTS bookings CASCADE;
DROP TABLE IF EXISTS loyalty_points CASCADE;

-- Create bookings table
CREATE TABLE bookings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  apartment_id UUID REFERENCES apartments(id) NOT NULL,
  check_in_date DATE NOT NULL,
  check_out_date DATE NOT NULL,
  total_guests INTEGER NOT NULL DEFAULT 1,
  total_cents INTEGER NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending', -- pending, confirmed, cancelled, completed
  special_requests TEXT,
  contact_info JSONB,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Create loyalty_points table
CREATE TABLE loyalty_points (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  points INTEGER NOT NULL,
  type TEXT NOT NULL, -- earned, redeemed
  booking_id UUID REFERENCES bookings(id),
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Add indexes for performance
CREATE INDEX idx_bookings_user ON bookings(user_id);
CREATE INDEX idx_bookings_apartment ON bookings(apartment_id);
CREATE INDEX idx_bookings_dates ON bookings(check_in_date, check_out_date);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_loyalty_points_user ON loyalty_points(user_id);

-- Enable RLS (Row Level Security)
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE loyalty_points ENABLE ROW LEVEL SECURITY;

-- RLS Policies for bookings
CREATE POLICY "Users can view their own bookings"
  ON bookings FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own bookings"
  ON bookings FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own bookings"
  ON bookings FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- RLS Policies for loyalty points
CREATE POLICY "Users can view their own loyalty points"
  ON loyalty_points FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own loyalty points"
  ON loyalty_points FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Insert sample bookings for testing (optional - comment out for production)
-- You can uncomment these after creating some test bookings