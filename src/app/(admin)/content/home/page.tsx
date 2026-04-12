import { requireRole } from '@/lib/auth'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Textarea } from '@/components/ui/textarea'
import { getContentSectionForAdmin } from '@/lib/content-service'
import { defaultHomepageContent } from '@/lib/content'
import { saveHomepageContent, publishHomepageContent } from './actions'
import { Home, Image as ImageIcon, FileText, Save } from 'lucide-react'

export default async function HomeContentManagement() {
  await requireRole(['admin', 'administrator'])

  const section = await getContentSectionForAdmin('homepage')
  const payload = (section?.payload as typeof defaultHomepageContent | undefined) ?? defaultHomepageContent

  return (
    <div className="space-y-8">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Homepage Content</h1>
          <p className="text-gray-600 mt-2">
            Manage the content displayed on your homepage.
          </p>
        </div>
        <form action={publishHomepageContent}>
          <Button type="submit" variant="outline">
            Publish
          </Button>
        </form>
      </div>

      <form action={saveHomepageContent} className="grid gap-6">
        {/* Hero Section */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <ImageIcon className="h-5 w-5" />
              Hero Section
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <Label htmlFor="heroTitleEn">Hero Title (EN)</Label>
              <Input
                id="heroTitleEn"
                name="heroTitleEn"
                defaultValue={payload.hero.title.en}
                className="mt-1"
              />
            </div>

            <div>
              <Label htmlFor="heroTitleIt">Hero Title (IT)</Label>
              <Input
                id="heroTitleIt"
                name="heroTitleIt"
                defaultValue={payload.hero.title.it}
                className="mt-1"
              />
            </div>

            <div>
              <Label htmlFor="heroSubtitleEn">Hero Subtitle (EN)</Label>
              <Textarea
                id="heroSubtitleEn"
                name="heroSubtitleEn"
                defaultValue={payload.hero.subtitle.en}
                className="mt-1"
                rows={2}
              />
            </div>

            <div>
              <Label htmlFor="heroSubtitleIt">Hero Subtitle (IT)</Label>
              <Textarea
                id="heroSubtitleIt"
                name="heroSubtitleIt"
                defaultValue={payload.hero.subtitle.it}
                className="mt-1"
                rows={2}
              />
            </div>

            <div>
              <Label htmlFor="heroCtaEn">Hero CTA (EN)</Label>
              <Input
                id="heroCtaEn"
                name="heroCtaEn"
                defaultValue={payload.hero.ctaText.en}
                className="mt-1"
              />
            </div>

            <div>
              <Label htmlFor="heroCtaIt">Hero CTA (IT)</Label>
              <Input
                id="heroCtaIt"
                name="heroCtaIt"
                defaultValue={payload.hero.ctaText.it}
                className="mt-1"
              />
            </div>

            <div>
              <Label htmlFor="heroImage1">Hero Image URL 1</Label>
              <Input id="heroImage1" name="heroImage1" defaultValue={payload.hero.backgroundImages[0] ?? ''} className="mt-1" />
            </div>

            <div>
              <Label htmlFor="heroImage2">Hero Image URL 2</Label>
              <Input id="heroImage2" name="heroImage2" defaultValue={payload.hero.backgroundImages[1] ?? ''} className="mt-1" />
            </div>

            <div>
              <Label htmlFor="heroImage3">Hero Image URL 3</Label>
              <Input id="heroImage3" name="heroImage3" defaultValue={payload.hero.backgroundImages[2] ?? ''} className="mt-1" />
            </div>
          </CardContent>
        </Card>

        {/* Featured Section */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Home className="h-5 w-5" />
              Featured Apartments Section
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <Label htmlFor="featuredTitle">Section Title</Label>
              <Input
                id="featuredTitle"
                name="featuredTitle"
                defaultValue={payload.featured.title}
                className="mt-1"
              />
            </div>

            <div>
              <Label htmlFor="featuredDescription">Section Description</Label>
              <Textarea
                id="featuredDescription"
                name="featuredDescription"
                defaultValue={payload.featured.description}
                className="mt-1"
                rows={3}
              />
            </div>
          </CardContent>
        </Card>

        {/* About Section */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <FileText className="h-5 w-5" />
              About Section
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <Label htmlFor="aboutTitle">About Title</Label>
              <Input
                id="aboutTitle"
                name="aboutTitle"
                defaultValue={payload.about.title}
                className="mt-1"
              />
            </div>

            <div>
              <Label htmlFor="aboutContent">About Content</Label>
              <Textarea
                id="aboutContent"
                name="aboutContent"
                defaultValue={payload.about.content}
                className="mt-1"
                rows={4}
              />
            </div>
          </CardContent>
        </Card>

        {/* SEO Settings */}
        <Card>
          <CardHeader>
            <CardTitle>SEO Settings</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <Label htmlFor="metaTitle">Meta Title</Label>
              <Input
                id="metaTitle"
                defaultValue="Venice Parcley - Luxury Artistic Apartments"
                className="mt-1"
              />
            </div>

            <div>
              <Label htmlFor="metaDescription">Meta Description</Label>
              <Textarea
                id="metaDescription"
                defaultValue="Discover unique artistic apartments in Venice. Luxury accommodations designed for art lovers, creative souls, and discerning travelers."
                className="mt-1"
                rows={3}
              />
            </div>
          </CardContent>
        </Card>

        <div className="flex justify-end">
          <Button type="submit">
            <Save className="mr-2 h-4 w-4" />
            Save Changes
          </Button>
        </div>
      </form>
    </div>
  )
}
