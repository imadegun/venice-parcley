import { Pool } from 'pg';

const connectionString = process.env.DATABASE_URL || 'postgresql://neondb_owner:npg_yOWN0gYS4Ttn@ep-orange-fog-aoaxaxgn-pooler.c-2.ap-southeast-1.aws.neon.tech/neondb?sslmode=require&channel_binding=require';

// Create the pool
export const pool = new Pool({
  connectionString,
  ssl: { rejectUnauthorized: false }
});

// Query helper
export const query = (text: string, params?: any[]) => pool.query(text, params);