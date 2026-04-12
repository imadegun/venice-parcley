import { NextRequest, NextResponse } from 'next/server'
import { getCurrentUser, getUserRole } from '@/lib/auth'
import {
  contentKeySchema,
  contentPayloadSchemaByKey,
  type ContentKey,
} from '@/lib/content-schema'
import {
  getContentSectionForAdmin,
  upsertDraftContentSection,
} from '@/lib/content-service'

function forbiddenResponse() {
  return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
}

async function requireAdminRole() {
  const user = await getCurrentUser()
  if (!user) return null

  const role = await getUserRole(user.id)
  if (!['admin', 'administrator'].includes(role)) return null

  return user
}

export async function GET(
  _request: NextRequest,
  context: { params: Promise<{ key: string }> }
) {
  const admin = await requireAdminRole()
  if (!admin) return forbiddenResponse()

  const { key } = await context.params
  const parsed = contentKeySchema.safeParse(key)
  if (!parsed.success) {
    return NextResponse.json({ error: 'Invalid content key' }, { status: 400 })
  }

  const section = await getContentSectionForAdmin(parsed.data)
  if (!section) {
    return NextResponse.json({ error: 'Content section not found' }, { status: 404 })
  }

  return NextResponse.json({ data: section })
}

export async function PATCH(
  request: NextRequest,
  context: { params: Promise<{ key: string }> }
) {
  const admin = await requireAdminRole()
  if (!admin) return forbiddenResponse()

  const { key } = await context.params
  const parsedKey = contentKeySchema.safeParse(key)

  if (!parsedKey.success) {
    return NextResponse.json({ error: 'Invalid content key' }, { status: 400 })
  }

  const body = await request.json()
  const validator = contentPayloadSchemaByKey[parsedKey.data]
  const parsedPayload = validator.safeParse(body?.payload)

  if (!parsedPayload.success) {
    return NextResponse.json(
      {
        error: 'Validation failed',
        details: parsedPayload.error.flatten(),
      },
      { status: 400 }
    )
  }

  try {
    const updated = await upsertDraftContentSection({
      key: parsedKey.data as ContentKey,
      payload: parsedPayload.data,
      updatedBy: admin.id,
    })

    return NextResponse.json({ data: updated })
  } catch (error) {
    return NextResponse.json(
      { error: error instanceof Error ? error.message : 'Failed to update content' },
      { status: 500 }
    )
  }
}

