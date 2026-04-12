import { NextRequest, NextResponse } from 'next/server'
import { getCurrentUser, getUserRole } from '@/lib/auth'
import { contentKeySchema } from '@/lib/content-schema'
import { publishContentSection } from '@/lib/content-service'

async function requireAdminRole() {
  const user = await getCurrentUser()
  if (!user) return null

  const role = await getUserRole(user.id)
  if (!['admin', 'administrator'].includes(role)) return null

  return user
}

export async function POST(request: NextRequest) {
  const admin = await requireAdminRole()
  if (!admin) {
    return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
  }

  const body = await request.json()
  const parsedKey = contentKeySchema.safeParse(body?.key)

  if (!parsedKey.success) {
    return NextResponse.json({ error: 'Invalid content key' }, { status: 400 })
  }

  try {
    const published = await publishContentSection({
      key: parsedKey.data,
      publishedBy: admin.id,
    })

    return NextResponse.json({ data: published })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Failed to publish content'
    const status = message.includes('not found') ? 404 : 500
    return NextResponse.json({ error: message }, { status })
  }
}

