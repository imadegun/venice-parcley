import { NextRequest, NextResponse } from 'next/server'
import { createServerClient } from '@/lib/supabase'

export async function GET() {
  try {
    const supabase = createServerClient()

    const { data, error } = await supabase
      .from('menu_items')
      .select('*')
      .eq('is_active', true)
      .order('sort_order', { ascending: true })

    if (error) {
      console.error('Error fetching menu items:', error)
      return NextResponse.json({ error: 'Failed to fetch menu items' }, { status: 500 })
    }

    return NextResponse.json(data)
  } catch (error) {
    console.error('Error in menu API:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}

export async function POST(request: NextRequest) {
  try {
    const supabase = createServerClient()
    const body = await request.json()

    const { title, href, is_active = true, sort_order = 0, content, map_embed, image_url } = body

    if (!title || !href) {
      return NextResponse.json({ error: 'Title and href are required' }, { status: 400 })
    }

    const { data, error } = await supabase
      .from('menu_items')
      .insert([{ title, href, is_active, sort_order, content, map_embed, image_url }])
      .select()
      .single()

    if (error) {
      console.error('Error creating menu item:', error)
      return NextResponse.json({ error: 'Failed to create menu item' }, { status: 500 })
    }

    return NextResponse.json(data, { status: 201 })
  } catch (error) {
    console.error('Error in menu API:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}