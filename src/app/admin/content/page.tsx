import { requireRole } from '@/lib/auth'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { FileText, Home, Image, Phone } from 'lucide-react'
import Link from 'next/link'

export default async function ContentManagement() {
  await requireRole(['admin', 'administrator'])

  const contentSections = [
    {
      title: 'Homepage Content',
      description: 'Manage hero section, featured apartments, and main content',
      href: '/admin/content/home',
      icon: Home
    },
    {
      title: 'Gallery Management',
      description: 'Upload and organize apartment photos and images',
      href: '/admin/gallery',
      icon: Image
    },
    {
      title: 'About Page',
      description: 'Edit company information and mission statement',
      href: '/admin/content/about',
      icon: FileText
    },
    {
      title: 'Contact Information',
      description: 'Update contact details and business information',
      href: '/admin/content/contact',
      icon: Phone
    }
  ]

  return (
    <div className="space-y-8">
      <div>
        <h1 className="text-3xl font-bold text-gray-900">Content Management</h1>
        <p className="text-gray-600 mt-2">
          Manage all website content, images, and information.
        </p>
      </div>

      <div className="grid gap-6 md:grid-cols-2">
        {contentSections.map((section) => {
          const Icon = section.icon
          return (
            <Card key={section.href} className="hover:shadow-lg transition-shadow">
              <CardHeader>
                <div className="flex items-center gap-3">
                  <Icon className="h-6 w-6 text-blue-600" />
                  <CardTitle className="text-xl">{section.title}</CardTitle>
                </div>
              </CardHeader>
              <CardContent>
                <p className="text-gray-600 mb-4">{section.description}</p>
                <Link href={section.href}>
                  <Button className="w-full">
                    Manage {section.title}
                  </Button>
                </Link>
              </CardContent>
            </Card>
          )
        })}
      </div>

      {/* Content Status */}
      <Card>
        <CardHeader>
          <CardTitle>Content Status</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid gap-4 md:grid-cols-3">
            <div className="text-center">
              <div className="text-2xl font-bold text-green-600">✓</div>
              <p className="text-sm text-gray-600">Homepage</p>
              <p className="text-xs text-green-600">Published</p>
            </div>
            <div className="text-center">
              <div className="text-2xl font-bold text-yellow-600">○</div>
              <p className="text-sm text-gray-600">Gallery</p>
              <p className="text-xs text-yellow-600">Needs Images</p>
            </div>
            <div className="text-center">
              <div className="text-2xl font-bold text-green-600">✓</div>
              <p className="text-sm text-gray-600">Contact</p>
              <p className="text-xs text-green-600">Complete</p>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}