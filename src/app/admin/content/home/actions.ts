'use server'

import { revalidatePath } from 'next/cache'
import { requireRole } from '@/lib/auth'
import { homepageContentSchema } from '@/lib/content-schema'
import { publishContentSection, upsertDraftContentSection } from '@/lib/content-service'
import { websiteContent } from '@/lib/content'

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
      backgroundImages: (() => {
        const images = [
          String(formData.get('heroImage1') || ''),
          String(formData.get('heroImage2') || ''),
          String(formData.get('heroImage3') || ''),
        ].filter(Boolean)
        return images.length > 0 ? images : websiteContent.hero.backgroundImages
      })(),
    },
    featured: {
      title: {
        en: String(formData.get('featuredTitleEn') || ''),
        it: String(formData.get('featuredTitleIt') || ''),
      },
      description: {
        en: String(formData.get('featuredDescriptionEn') || ''),
        it: String(formData.get('featuredDescriptionIt') || ''),
      },
    },
    about: {
      title: {
        en: String(formData.get('aboutTitleEn') || ''),
        it: String(formData.get('aboutTitleIt') || ''),
      },
      content: {
        en: String(formData.get('aboutContentEn') || ''),
        it: String(formData.get('aboutContentIt') || ''),
      },
    },
    intro: {
      tagline: {
        en: String(formData.get('introTaglineEn') || ''),
        it: String(formData.get('introTaglineIt') || ''),
      },
      title: {
        en: String(formData.get('introTitleEn') || ''),
        it: String(formData.get('introTitleIt') || ''),
      },
      description: {
        en: String(formData.get('introDescriptionEn') || ''),
        it: String(formData.get('introDescriptionIt') || ''),
      },
    },
  }

  console.log('✅ saveHomepageContent: payload being validated:', JSON.stringify(payload, null, 2))
  const parsed = homepageContentSchema.safeParse(payload)
  if (!parsed.success) {
    console.error('❌ Validation error:', JSON.stringify(parsed.error.flatten(), null, 2))
    throw new Error('Validation failed. Please fill all required fields with valid values.')
  }

  console.log('✅ saveHomepageContent: validated payload:', JSON.stringify(parsed.data, null, 2))
  const result = await upsertDraftContentSection({
    key: 'homepage',
    payload: parsed.data,
    updatedBy: user.id,
  })
  console.log('✅ saveHomepageContent: saved to DB with status:', result.status, 'id:', result.id)

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