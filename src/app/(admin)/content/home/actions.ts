'use server'

import { revalidatePath } from 'next/cache'
import { requireRole } from '@/lib/auth'
import { homepageContentSchema } from '@/lib/content-schema'
import { publishContentSection, upsertDraftContentSection } from '@/lib/content-service'

export type SaveHomepageContentState = {
  ok: boolean
  message: string
}

export async function saveHomepageContent(
  formData: FormData
): Promise<void> {
  const user = await requireRole(['admin', 'administrator'])

  const payload = {
    hero: {
      title: {
        en: String(formData.get('heroTitleEn') || ''),
        it: String(formData.get('heroTitleIt') || ''),
      },
      subtitle: {
        en: String(formData.get('heroSubtitleEn') || ''),
        it: String(formData.get('heroSubtitleIt') || ''),
      },
      ctaText: {
        en: String(formData.get('heroCtaEn') || ''),
        it: String(formData.get('heroCtaIt') || ''),
      },
      backgroundImages: [
        String(formData.get('heroImage1') || ''),
        String(formData.get('heroImage2') || ''),
        String(formData.get('heroImage3') || ''),
      ].filter(Boolean),
    },
    featured: {
      title: String(formData.get('featuredTitle') || ''),
      description: String(formData.get('featuredDescription') || ''),
    },
    about: {
      title: String(formData.get('aboutTitle') || ''),
      content: String(formData.get('aboutContent') || ''),
    },
  }

  const parsed = homepageContentSchema.safeParse(payload)
  if (!parsed.success) {
    throw new Error('Validation failed. Please fill all required fields with valid values.')
  }

  await upsertDraftContentSection({
    key: 'homepage',
    payload: parsed.data,
    updatedBy: user.id,
  })

  revalidatePath('/')
  revalidatePath('/admin/content/home')
}

export async function publishHomepageContent(): Promise<void> {
  const user = await requireRole(['admin', 'administrator'])

  await publishContentSection({
    key: 'homepage',
    publishedBy: user.id,
  })

  revalidatePath('/')
  revalidatePath('/admin/content/home')
}

