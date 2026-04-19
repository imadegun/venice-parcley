import { z } from 'zod'

export const contentKeySchema = z.enum(['homepage', 'about', 'contact'])

const localizedTextSchema = z.object({
  en: z.string(),
  it: z.string(),
})

export const homepageContentSchema = z.object({
  hero: z.object({
    title: localizedTextSchema,
    subtitle: localizedTextSchema,
    ctaText: localizedTextSchema,
    backgroundImages: z.array(z.string().url()).min(0),
  }),
  featured: z.object({
    title: localizedTextSchema,
    description: localizedTextSchema,
  }).optional(),
  about: z.object({
    title: localizedTextSchema,
    content: localizedTextSchema,
  }).optional(),
  intro: z.object({
    tagline: localizedTextSchema,
    title: localizedTextSchema,
    description: localizedTextSchema,
  }).optional(),
})

export const aboutContentSchema = z.object({
  title: localizedTextSchema,
  description: localizedTextSchema,
})

export const contactContentSchema = z.object({
  title: z.string().min(1),
  description: z.string().min(1),
  email: z.string().email().optional(),
  phone: z.string().optional(),
})

export const contentPayloadSchemaByKey = {
  homepage: homepageContentSchema,
  about: aboutContentSchema,
  contact: contactContentSchema,
} as const

export type ContentKey = z.infer<typeof contentKeySchema>
export type HomepageContentPayload = z.infer<typeof homepageContentSchema>

