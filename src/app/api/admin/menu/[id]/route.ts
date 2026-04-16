import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase-server'

export async function PUT(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const supabase = createClient()
    const body = await request.json()

    const { label, href, is_active, sort_order } = body

    const { data, error } = await supabase
      .from('menu_items')
      .update({ label, href, is_active, sort_order })
      .eq('id', params.id)
      .select()
      .single()

    if (error) {
      console.error('Error updating menu item:', error)
      return NextResponse.json({ error: 'Failed to update menu item' }, { status: 500 })
    }

    return NextResponse.json(data)
  } catch (error) {
    console.error('Error in menu API:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}

export async function DELETE(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const supabase = createClient()

    const { error } = await supabase
      .from('menu_items')
      .delete()
      .eq('id', params.id)

    if (error) {
      console.error('Error deleting menu item:', error)
      return NextResponse.json({ error: 'Failed to delete menu item' }, { status: 500 })
    }

    return NextResponse.json({ success: true })
  } catch (error) {
    console.error('Error in menu API:', error)
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 })
  }
}