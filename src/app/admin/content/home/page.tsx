'use client'

import { useEffect, useState } from 'react'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Textarea } from '@/components/ui/textarea'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { UnifiedImageManager } from '@/components/admin/unified-image-manager'
import { getContentSectionForAdmin } from '@/lib/content-service'
import { defaultHomepageContent } from '@/lib/content'
import { saveHomepageContent, publishHomepageContent } from './actions'
import { Home, Image as ImageIcon, FileText, Save, Globe } from 'lucide-react'

export default function HomeContentManagement() {
  const [payload, setPayload] = useState(defaultHomepageContent)
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [publishing, setPublishing] = useState(false)

  // Form states
  const [heroImages, setHeroImages] = useState({ images: [] as string[], mainImageIndex: 0 })

  // Controlled form values
  const [heroTitleEn, setHeroTitleEn] = useState('')
  const [heroTitleIt, setHeroTitleIt] = useState('')
  const [heroSubtitleEn, setHeroSubtitleEn] = useState('')
  const [heroSubtitleIt, setHeroSubtitleIt] = useState('')
  const [heroCtaEn, setHeroCtaEn] = useState('')
  const [heroCtaIt, setHeroCtaIt] = useState('')
  const [featuredTitleEn, setFeaturedTitleEn] = useState('')
  const [featuredTitleIt, setFeaturedTitleIt] = useState('')
  const [featuredDescriptionEn, setFeaturedDescriptionEn] = useState('')
  const [featuredDescriptionIt, setFeaturedDescriptionIt] = useState('')
  const [aboutTitleEn, setAboutTitleEn] = useState('')
  const [aboutTitleIt, setAboutTitleIt] = useState('')
  const [aboutContentEn, setAboutContentEn] = useState('')
  const [aboutContentIt, setAboutContentIt] = useState('')
  const [introTaglineEn, setIntroTaglineEn] = useState('')
  const [introTaglineIt, setIntroTaglineIt] = useState('')
  const [introTitleEn, setIntroTitleEn] = useState('')
  const [introTitleIt, setIntroTitleIt] = useState('')
  const [introDescriptionEn, setIntroDescriptionEn] = useState('')
  const [introDescriptionIt, setIntroDescriptionIt] = useState('')
  const [metaTitle, setMetaTitle] = useState('')
  const [metaDescription, setMetaDescription] = useState('')

  useEffect(() => {
    loadContent()
  }, [])

  useEffect(() => {
    if (payload.hero) {
      setHeroTitleEn(payload.hero.title?.en || '')
      setHeroTitleIt(payload.hero.title?.it || '')
      setHeroSubtitleEn(payload.hero.subtitle?.en || '')
      setHeroSubtitleIt(payload.hero.subtitle?.it || '')
      setHeroCtaEn(payload.hero.ctaText?.en || '')
      setHeroCtaIt(payload.hero.ctaText?.it || '')
      setHeroImages({
        images: payload.hero.backgroundImages || [],
        mainImageIndex: 0
      })
    }
    if (payload.featured) {
      setFeaturedTitleEn(payload.featured.title?.en || '')
      setFeaturedTitleIt(payload.featured.title?.it || '')
      setFeaturedDescriptionEn(payload.featured.description?.en || '')
      setFeaturedDescriptionIt(payload.featured.description?.it || '')
    }
    if (payload.about) {
      setAboutTitleEn(payload.about.title?.en || '')
      setAboutTitleIt(payload.about.title?.it || '')
      setAboutContentEn(payload.about.content?.en || '')
      setAboutContentIt(payload.about.content?.it || '')
    }
    // For intro, use payload if exists, otherwise fall back to defaults
    if (payload.intro) {
      setIntroTaglineEn(payload.intro.tagline?.en || '')
      setIntroTaglineIt(payload.intro.tagline?.it || '')
      setIntroTitleEn(payload.intro.title?.en || '')
      setIntroTitleIt(payload.intro.title?.it || '')
      setIntroDescriptionEn(payload.intro.description?.en || '')
      setIntroDescriptionIt(payload.intro.description?.it || '')
    } else {
      // Use defaults if no intro in payload
      const defaultIntro = defaultHomepageContent.intro || {
        tagline: { en: '', it: '' },
        title: { en: '', it: '' },
        description: { en: '', it: '' }
      }
      setIntroTaglineEn(defaultIntro.tagline.en)
      setIntroTaglineIt(defaultIntro.tagline.it)
      setIntroTitleEn(defaultIntro.title.en)
      setIntroTitleIt(defaultIntro.title.it)
      setIntroDescriptionEn(defaultIntro.description.en)
      setIntroDescriptionIt(defaultIntro.description.it)
    }
    setMetaTitle('Venice Parcley - Luxury Artistic Apartments')
    setMetaDescription('Discover unique artistic apartments in Venice. Luxury accommodations designed for art lovers, creative souls, and discerning travelers.')
  }, [payload])

  async function loadContent() {
    try {
      const section = await getContentSectionForAdmin('homepage')
      const data = (section?.payload as typeof defaultHomepageContent | undefined) ?? defaultHomepageContent
      setPayload(data)
    } catch (error) {
      console.error('Failed to load content:', error)
    } finally {
      setLoading(false)
    }
  }

  async function handleSave(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault()
    setSaving(true)

    // Build FormData from React state to ensure all fields are included
    // regardless of which tab is currently active
    const formData = new FormData()

    // Hero fields
    formData.append('heroTitleEn', heroTitleEn)
    formData.append('heroTitleIt', heroTitleIt)
    formData.append('heroSubtitleEn', heroSubtitleEn)
    formData.append('heroSubtitleIt', heroSubtitleIt)
    formData.append('heroCtaEn', heroCtaEn)
    formData.append('heroCtaIt', heroCtaIt)

    // Hero images
    heroImages.images.forEach((image, index) => {
      formData.set(`heroImage${index + 1}`, image)
    })
    // Clear unused image fields
    for (let i = heroImages.images.length + 1; i <= 3; i++) {
      formData.set(`heroImage${i}`, '')
    }

    // Featured fields
    formData.append('featuredTitleEn', featuredTitleEn)
    formData.append('featuredTitleIt', featuredTitleIt)
    formData.append('featuredDescriptionEn', featuredDescriptionEn)
    formData.append('featuredDescriptionIt', featuredDescriptionIt)

    // About fields
    formData.append('aboutTitleEn', aboutTitleEn)
    formData.append('aboutTitleIt', aboutTitleIt)
    formData.append('aboutContentEn', aboutContentEn)
    formData.append('aboutContentIt', aboutContentIt)

    // Intro fields (Mobile Intro Section)
    formData.append('introTaglineEn', introTaglineEn)
    formData.append('introTaglineIt', introTaglineIt)
    formData.append('introTitleEn', introTitleEn)
    formData.append('introTitleIt', introTitleIt)
    formData.append('introDescriptionEn', introDescriptionEn)
    formData.append('introDescriptionIt', introDescriptionIt)

    // SEO fields (not saved to DB yet but included for completeness)
    formData.append('metaTitle', metaTitle)
    formData.append('metaDescription', metaDescription)

    // Debug: log all form data entries
    console.log('📝 FormData entries (from state):')
    for (const [key, value] of formData.entries()) {
      console.log('  ', key, ':', value)
    }

    try {
      await saveHomepageContent(formData)
      await loadContent() // Reload to get updated data
      alert('Content saved successfully!')
    } catch (error) {
      console.error('Failed to save:', error)
      alert('Failed to save: ' + (error instanceof Error ? error.message : String(error)))
    } finally {
      setSaving(false)
    }
  }

  async function handlePublish() {
    setPublishing(true)
    try {
      await publishHomepageContent()
      await loadContent()
      alert('Content published successfully!')
    } catch (error) {
      console.error('Failed to publish:', error)
      alert('Failed to publish: ' + (error instanceof Error ? error.message : String(error)))
    } finally {
      setPublishing(false)
    }
  }

  if (loading) {
    return <div className="p-8">Loading content...</div>
  }

  return (
    <div className="space-y-8">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Homepage Content</h1>
          <p className="text-gray-600 mt-2">
            Manage the content displayed on your homepage.
          </p>
        </div>
        <Button onClick={handlePublish} variant="outline" disabled={publishing}>
          {publishing ? 'Publishing...' : 'Publish'}
        </Button>
      </div>

      <form onSubmit={handleSave} className="space-y-6">
        <Tabs defaultValue="hero" className="w-full">
          <TabsList className="grid w-full grid-cols-5">
            <TabsTrigger value="hero" className="flex items-center gap-2">
              <ImageIcon className="h-4 w-4" />
              Hero
            </TabsTrigger>
            <TabsTrigger value="intro" className="flex items-center gap-2">
              <FileText className="h-4 w-4" />
              Intro
            </TabsTrigger>
            <TabsTrigger value="featured" className="flex items-center gap-2">
              <Home className="h-4 w-4" />
              Featured
            </TabsTrigger>
            <TabsTrigger value="about" className="flex items-center gap-2">
              <FileText className="h-4 w-4" />
              About
            </TabsTrigger>
            <TabsTrigger value="seo" className="flex items-center gap-2">
              <Globe className="h-4 w-4" />
              SEO
            </TabsTrigger>
          </TabsList>

          <TabsContent value="hero" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>Hero Section</CardTitle>
                <p className="text-sm text-gray-600">Configure the main hero banner content</p>
              </CardHeader>
              <CardContent className="space-y-6">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div className="space-y-4">
                    <h4 className="font-medium text-gray-900">English Content</h4>
                    <div>
                      <Label htmlFor="heroTitleEn">Title</Label>
                      <Input
                        id="heroTitleEn"
                        name="heroTitleEn"
                        value={heroTitleEn}
                        onChange={e => setHeroTitleEn(e.target.value)}
                        className="mt-1"
                      />
                    </div>
                    <div>
                      <Label htmlFor="heroSubtitleEn">Subtitle</Label>
                      <Textarea
                        id="heroSubtitleEn"
                        name="heroSubtitleEn"
                        value={heroSubtitleEn}
                        onChange={e => setHeroSubtitleEn(e.target.value)}
                        className="mt-1"
                        rows={3}
                      />
                    </div>
                    <div>
                      <Label htmlFor="heroCtaEn">Call-to-Action Text</Label>
                      <Input
                        id="heroCtaEn"
                        name="heroCtaEn"
                        value={heroCtaEn}
                        onChange={e => setHeroCtaEn(e.target.value)}
                        className="mt-1"
                      />
                    </div>
                  </div>
                  <div className="space-y-4">
                    <h4 className="font-medium text-gray-900">Italian Content</h4>
                    <div>
                      <Label htmlFor="heroTitleIt">Title</Label>
                      <Input
                        id="heroTitleIt"
                        name="heroTitleIt"
                        value={heroTitleIt}
                        onChange={e => setHeroTitleIt(e.target.value)}
                        className="mt-1"
                      />
                    </div>
                    <div>
                      <Label htmlFor="heroSubtitleIt">Subtitle</Label>
                      <Textarea
                        id="heroSubtitleIt"
                        name="heroSubtitleIt"
                        value={heroSubtitleIt}
                        onChange={e => setHeroSubtitleIt(e.target.value)}
                        className="mt-1"
                        rows={3}
                      />
                    </div>
                    <div>
                      <Label htmlFor="heroCtaIt">Call-to-Action Text</Label>
                      <Input
                        id="heroCtaIt"
                        name="heroCtaIt"
                        value={heroCtaIt}
                        onChange={e => setHeroCtaIt(e.target.value)}
                        className="mt-1"
                      />
                    </div>
                  </div>
                </div>
                <div>
                  <Label>Hero Background Images</Label>
                  <div className="mt-2">
                    <UnifiedImageManager
                      value={heroImages}
                      slug="homepage-hero"
                      onChange={setHeroImages}
                    />
                  </div>
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="intro" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>Intro Section</CardTitle>
                <p className="text-sm text-gray-600">Configure the introductory text displayed below the hero</p>
              </CardHeader>
              <CardContent className="space-y-6">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div className="space-y-4">
                    <h4 className="font-medium text-gray-900">English Content</h4>
                    <div>
                      <Label htmlFor="introTaglineEn">Tagline (uppercase)</Label>
                      <Input
                        id="introTaglineEn"
                        name="introTaglineEn"
                        value={introTaglineEn}
                        onChange={e => setIntroTaglineEn(e.target.value)}
                        className="mt-1"
                      />
                    </div>
                    <div>
                      <Label htmlFor="introTitleEn">Title</Label>
                      <Input
                        id="introTitleEn"
                        name="introTitleEn"
                        value={introTitleEn}
                        onChange={e => setIntroTitleEn(e.target.value)}
                        className="mt-1"
                      />
                    </div>
                    <div>
                      <Label htmlFor="introDescriptionEn">Description</Label>
                      <Textarea
                        id="introDescriptionEn"
                        name="introDescriptionEn"
                        value={introDescriptionEn}
                        onChange={e => setIntroDescriptionEn(e.target.value)}
                        className="mt-1"
                        rows={4}
                      />
                    </div>
                  </div>
                  <div className="space-y-4">
                    <h4 className="font-medium text-gray-900">Italian Content</h4>
                    <div>
                      <Label htmlFor="introTaglineIt">Tagline (uppercase)</Label>
                      <Input
                        id="introTaglineIt"
                        name="introTaglineIt"
                        value={introTaglineIt}
                        onChange={e => setIntroTaglineIt(e.target.value)}
                        className="mt-1"
                      />
                    </div>
                    <div>
                      <Label htmlFor="introTitleIt">Title</Label>
                      <Input
                        id="introTitleIt"
                        name="introTitleIt"
                        value={introTitleIt}
                        onChange={e => setIntroTitleIt(e.target.value)}
                        className="mt-1"
                      />
                    </div>
                    <div>
                      <Label htmlFor="introDescriptionIt">Description</Label>
                      <Textarea
                        id="introDescriptionIt"
                        name="introDescriptionIt"
                        value={introDescriptionIt}
                        onChange={e => setIntroDescriptionIt(e.target.value)}
                        className="mt-1"
                        rows={4}
                      />
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="featured" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>Featured Apartments Section</CardTitle>
                <p className="text-sm text-gray-600">Configure the featured apartments display</p>
              </CardHeader>
              <CardContent className="space-y-6">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div className="space-y-4">
                    <h4 className="font-medium text-gray-900">English Content</h4>
                    <div>
                      <Label htmlFor="featuredTitleEn">Section Title</Label>
                      <Input
                        id="featuredTitleEn"
                        name="featuredTitleEn"
                        value={featuredTitleEn}
                        onChange={e => setFeaturedTitleEn(e.target.value)}
                        className="mt-1"
                      />
                    </div>
                    <div>
                      <Label htmlFor="featuredDescriptionEn">Section Description</Label>
                      <Textarea
                        id="featuredDescriptionEn"
                        name="featuredDescriptionEn"
                        value={featuredDescriptionEn}
                        onChange={e => setFeaturedDescriptionEn(e.target.value)}
                        className="mt-1"
                        rows={4}
                      />
                    </div>
                  </div>
                  <div className="space-y-4">
                    <h4 className="font-medium text-gray-900">Italian Content</h4>
                    <div>
                      <Label htmlFor="featuredTitleIt">Section Title</Label>
                      <Input
                        id="featuredTitleIt"
                        name="featuredTitleIt"
                        value={featuredTitleIt}
                        onChange={e => setFeaturedTitleIt(e.target.value)}
                        className="mt-1"
                      />
                    </div>
                    <div>
                      <Label htmlFor="featuredDescriptionIt">Section Description</Label>
                      <Textarea
                        id="featuredDescriptionIt"
                        name="featuredDescriptionIt"
                        value={featuredDescriptionIt}
                        onChange={e => setFeaturedDescriptionIt(e.target.value)}
                        className="mt-1"
                        rows={4}
                      />
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="about" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>About Section</CardTitle>
                <p className="text-sm text-gray-600">Configure the about section content</p>
              </CardHeader>
              <CardContent className="space-y-6">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div className="space-y-4">
                    <h4 className="font-medium text-gray-900">English Content</h4>
                    <div>
                      <Label htmlFor="aboutTitleEn">About Title</Label>
                      <Input
                        id="aboutTitleEn"
                        name="aboutTitleEn"
                        value={aboutTitleEn}
                        onChange={e => setAboutTitleEn(e.target.value)}
                        className="mt-1"
                      />
                    </div>
                    <div>
                      <Label htmlFor="aboutContentEn">About Content</Label>
                      <Textarea
                        id="aboutContentEn"
                        name="aboutContentEn"
                        value={aboutContentEn}
                        onChange={e => setAboutContentEn(e.target.value)}
                        className="mt-1"
                        rows={6}
                      />
                    </div>
                  </div>
                  <div className="space-y-4">
                    <h4 className="font-medium text-gray-900">Italian Content</h4>
                    <div>
                      <Label htmlFor="aboutTitleIt">About Title</Label>
                      <Input
                        id="aboutTitleIt"
                        name="aboutTitleIt"
                        value={aboutTitleIt}
                        onChange={e => setAboutTitleIt(e.target.value)}
                        className="mt-1"
                      />
                    </div>
                    <div>
                      <Label htmlFor="aboutContentIt">About Content</Label>
                      <Textarea
                        id="aboutContentIt"
                        name="aboutContentIt"
                        value={aboutContentIt}
                        onChange={e => setAboutContentIt(e.target.value)}
                        className="mt-1"
                        rows={6}
                      />
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="seo" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>SEO Settings</CardTitle>
                <p className="text-sm text-gray-600">Configure meta tags and SEO information</p>
              </CardHeader>
              <CardContent className="space-y-4">
                <div>
                  <Label htmlFor="metaTitle">Meta Title</Label>
                  <Input
                    id="metaTitle"
                    name="metaTitle"
                    value={metaTitle}
                    onChange={e => setMetaTitle(e.target.value)}
                    className="mt-1"
                  />
                </div>
                <div>
                  <Label htmlFor="metaDescription">Meta Description</Label>
                  <Textarea
                    id="metaDescription"
                    name="metaDescription"
                    value={metaDescription}
                    onChange={e => setMetaDescription(e.target.value)}
                    className="mt-1"
                    rows={3}
                  />
                </div>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>

        <div className="flex justify-end pt-6 border-t">
          <Button type="submit" disabled={saving}>
            <Save className="mr-2 h-4 w-4" />
            {saving ? 'Saving...' : 'Save Changes'}
          </Button>
        </div>
      </form>
    </div>
  )
}