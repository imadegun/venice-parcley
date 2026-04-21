-- Enable required PostgreSQL extensions for Neon database
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create custom types
CREATE TYPE booking_status AS ENUM ('confirmed', 'cancelled', 'completed');
CREATE TYPE user_role AS ENUM ('guest', 'member', 'admin');
CREATE TYPE loyalty_point_type AS ENUM ('earned', 'redeemed');