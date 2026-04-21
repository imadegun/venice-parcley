-- Add the missing artistic_features column to apartments table
ALTER TABLE apartments ADD COLUMN artistic_features TEXT[] DEFAULT '{}';