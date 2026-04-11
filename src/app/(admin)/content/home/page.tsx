import { requireRole } from '@/lib/auth'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Textarea } from '@/components/ui/textarea'
import { Home, Image, FileText, Save } from 'lucide-react'

export default async function HomeContentManagement() {
  await requireRole(['admin', 'administrator'])

  // Mock current content - in real app, fetch from database
  const currentContent = {
    heroTitle: "Discover Luxury Artistic Apartments in Venice",
    heroSubtitle: "Unique spaces designed for art lovers, creative souls, and discerning travelers",
    featuredDescription: "Experience Venice like never before in our carefully curated collection of artistic apartments.",
    aboutTitle: "About Venice Parcley",
    aboutContent: "We connect art lovers with extraordinary living spaces in Venice, offering a unique blend of luxury accommodation and artistic inspiration."
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
        <Button>
          <Save className="mr-2 h-4 w-4" />
          Save Changes
        </Button>
      </div>

      <div className="grid gap-6">
        {/* Hero Section */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Image className="h-5 w-5" />
              Hero Section
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <Label htmlFor="heroTitle">Hero Title</Label>
              <Input
                id="heroTitle"
                defaultValue={currentContent.heroTitle}
                className="mt-1"
              />
            </div>

            <div>
              <Label htmlFor="heroSubtitle">Hero Subtitle</Label>
              <Textarea
                id="heroSubtitle"
                defaultValue={currentContent.heroSubtitle}
                className="mt-1"
                rows={2}
              />
            </div>

            <div>
              <Label htmlFor="heroImage">Hero Background Image</Label>
              <div className="mt-1 flex items-center gap-4">
                <Button variant="outline">
                  <Image className="mr-2 h-4 w-4" />
                  Change Image
                </Button>
                <span className="text-sm text-gray-500">hero-background.jpg</span>
              </div>
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
                defaultValue="Featured Apartments"
                className="mt-1"
              />
            </div>

            <div>
              <Label htmlFor="featuredDescription">Section Description</Label>
              <Textarea
                id="featuredDescription"
                defaultValue={currentContent.featuredDescription}
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
                defaultValue={currentContent.aboutTitle}
                className="mt-1"
              />
            </div>

            <div>
              <Label htmlFor="aboutContent">About Content</Label>
              <Textarea
                id="aboutContent"
                defaultValue={currentContent.aboutContent}
                className="mt-1"
                rows={4}
              />
            </div>

            <div>
              <Label htmlFor="aboutImage">About Image</Label>
              <div className="mt-1 flex items-center gap-4">
                <Button variant="outline">
                  <Image className="mr-2 h-4 w-4" />
                  Change Image
                </Button>
                <span className="text-sm text-gray-500">about-venice.jpg</span>
              </div>
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
      </div>
    </div>
  )
}