-- Check homepage content in database
SELECT id, key, status, version, updated_at, payload
FROM content_sections
WHERE key = 'homepage'
ORDER BY version DESC
LIMIT 5;

-- Check all content sections
SELECT key, status, version, updated_at, 
       payload ->> 'about' as about,
       payload ->> 'intro' as intro,
       payload ->> 'featured' as featured,
       payload ->> 'hero' as hero
FROM content_sections
ORDER BY updated_at DESC
LIMIT 10;
