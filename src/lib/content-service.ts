import { createServerSupabaseClient } from '@/lib/supabase'
import {
  contentKeySchema,
  contentPayloadSchemaByKey,
  type ContentKey,
} from '@/lib/content-schema'
import type { Database, Json } from '@/types/database'

type ContentSectionRow = Database['public']['Tables']['content_sections']['Row']

export async function getContentSectionForAdmin(key: string): Promise<ContentSectionRow | null> {
  const parsed = contentKeySchema.safeParse(key)
  if (!parsed.success) return null

  const supabase = createServerSupabaseClient()
  const { data, error } = await supabase
    .from('content_sections')
    .select('*')
    .eq('key', parsed.data)
    .single()

  if (error) return null
  return data as ContentSectionRow
}

export async function getPublishedContentSection(key: ContentKey): Promise<ContentSectionRow | null> {
  const supabase = createServerSupabaseClient()
  const { data, error } = await supabase
    .from('content_sections')
    .select('*')
    .eq('key', key)
    .eq('status', 'published')
    .single()

  if (error) {
    console.log(`🔍 getPublishedContentSection: no published row for key="${key}" -`, error.message)
    return null
  }
  console.log(`🔍 getPublishedContentSection: found published row for key="${key}"`, { id: data.id, status: data.status })
  return data as ContentSectionRow
}

export async function upsertDraftContentSection(args: {
  key: ContentKey
  payload: unknown
  updatedBy?: string
}): Promise<ContentSectionRow> {
  const validator = contentPayloadSchemaByKey[args.key]
  const parsed = validator.safeParse(args.payload)

  if (!parsed.success) {
    throw new Error(JSON.stringify(parsed.error.flatten()))
  }

  const supabase = createServerSupabaseClient()

  const existing = await getContentSectionForAdmin(args.key)
  const nextVersion = existing ? existing.version + 1 : 1

  const { data, error } = await supabase
    .from('content_sections')
    .upsert(
      {
        key: args.key,
        payload: parsed.data as Json,
        status: existing?.status === 'published' ? 'published' : 'draft',
        version: nextVersion,
        updated_by: args.updatedBy,
      },
      { onConflict: 'key' }
    )
    .select('*')
    .single()

  if (error || !data) {
    throw new Error('Failed to save content section')
  }

  return data as ContentSectionRow
}

export async function publishContentSection(args: {
  key: ContentKey
  publishedBy?: string
}): Promise<ContentSectionRow> {
  const supabase = createServerSupabaseClient()
  const current = await getContentSectionForAdmin(args.key)

  if (!current) {
    throw new Error('Content section not found')
  }

  const { data: published, error: publishError } = await supabase
    .from('content_sections')
    .update({
      status: 'published',
      updated_by: args.publishedBy,
      version: current.version + 1,
    })
    .eq('id', current.id)
    .select('*')
    .single()

  if (publishError || !published) {
    throw new Error('Failed to publish content section')
  }

  const { error: revisionError } = await supabase.from('content_revisions').insert({
    section_id: published.id,
    key: published.key,
    payload: published.payload,
    version: published.version,
    published_by: args.publishedBy,
  })

  if (revisionError) {
    throw new Error('Failed to create content revision')
  }

  return published as ContentSectionRow
}

