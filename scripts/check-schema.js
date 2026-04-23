/**
 * Diagnostic script to check if the 'content' column exists in menu_items
 * Run: node scripts/check-schema.js
 *
 * Requires: npm install @supabase/supabase-js dotenv
 */

import { config } from 'dotenv'
import { createClient } from '@supabase/supabase-js'

config({ path: '.env.local' })

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || process.env.NEXT_PUBLIC_SUPABASE_URL
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseAnonKey) {
  console.error('❌ Error: NEXT_PUBLIC_SUPABASE_URL and NEXT_PUBLIC_SUPABASE_ANON_KEY must be set in .env.local')
  process.exit(1)
}

const supabase = createClient(supabaseUrl, supabaseAnonKey)

async function checkSchema() {
  console.log('🔍 Checking menu_items schema...\n')

  try {
    // Try to query the content column directly
    const { data, error } = await supabase
      .from('menu_items')
      .select('id, label, content')
      .limit(1)

    if (error) {
      console.error('❌ Error querying menu_items:')
      console.error('   Code:', error.code)
      console.error('   Message:', error.message)
      console.error('   Details:', error.details)
      console.error('   Hint:', error.hint)
      console.log('\n📝 This likely means the "content" column does not exist in the database.')
      console.log('   Run the migration: ALTER TABLE menu_items ADD COLUMN content TEXT;')
      process.exit(1)
    }

    console.log('✅ Successfully queried menu_items with content column!')
    console.log('   Sample row:', data[0] || 'No rows yet')
    console.log('\n✓ The content column exists and is accessible.')

  } catch (err) {
    console.error('❌ Unexpected error:', err)
    process.exit(1)
  }
}

checkSchema()
