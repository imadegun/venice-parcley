-- Check what columns actually exist in the apartments table
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'apartments'
ORDER BY ordinal_position;