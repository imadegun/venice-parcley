import { requireRole } from '@/lib/auth'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Badge } from '@/components/ui/badge'
import { Upload, Image as ImageIcon, Trash2 } from 'lucide-react'

export default async function GalleryManagement() {
  await requireRole(['admin', 'administrator'])

  // Mock data - in real app, fetch from database
  const galleryItems = [
    {
      id: '1',
      name: 'Artistic Studio Living Room',
      type: 'apartment',
      url: '/images/apartment-1.jpg',
      uploadedAt: '2024-01-15'
    },
    {
      id: '2',
      name: 'Design Loft Kitchen',
      type: 'apartment',
      url: '/images/apartment-2.jpg',
      uploadedAt: '2024-01-16'
    }
  ]

  return (
    <div className="space-y-8">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Gallery Management</h1>
          <p className="text-gray-600 mt-2">
            Upload and manage images for apartments and website content.
          </p>
        </div>
        <Button>
          <Upload className="mr-2 h-4 w-4" />
          Upload Images
        </Button>
      </div>

      {/* Upload Zone */}
      <Card>
        <CardContent className="p-8">
          <div className="text-center">
            <Upload className="mx-auto h-12 w-12 text-gray-400" />
            <h3 className="mt-4 text-lg font-medium text-gray-900">Upload Images</h3>
            <p className="mt-2 text-gray-600">
              Drag and drop images here, or click to select files
            </p>
            <div className="mt-4">
              <input
                type="file"
                multiple
                accept="image/*"
                className="hidden"
                id="image-upload"
              />
              <label htmlFor="image-upload">
                <Button variant="outline" className="cursor-pointer">
                  Choose Files
                </Button>
              </label>
            </div>
            <p className="mt-2 text-sm text-gray-500">
              Supports: JPG, PNG, WebP up to 10MB each
            </p>
          </div>
        </CardContent>
      </Card>

      {/* Gallery Grid */}
      <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
        {galleryItems.map((item) => (
          <Card key={item.id}>
            <CardHeader className="pb-3">
              <div className="flex items-center justify-between">
                <CardTitle className="text-lg">{item.name}</CardTitle>
                <Badge variant="secondary">{item.type}</Badge>
              </div>
            </CardHeader>
            <CardContent>
              <div className="aspect-video bg-gray-100 rounded-lg flex items-center justify-center mb-4">
                <ImageIcon className="h-12 w-12 text-gray-400" />
              </div>
              <div className="flex items-center justify-between text-sm text-gray-600">
                <span>Uploaded {item.uploadedAt}</span>
                <Button variant="ghost" size="sm" className="text-red-600 hover:text-red-700">
                  <Trash2 className="h-4 w-4" />
                </Button>
              </div>
            </CardContent>
          </Card>
        ))}

        {/* Add New Card */}
        <Card className="border-dashed border-2 hover:border-blue-400 transition-colors">
          <CardContent className="p-8 text-center">
            <Upload className="mx-auto h-8 w-8 text-gray-400" />
            <p className="mt-2 text-sm text-gray-600">Add more images</p>
          </CardContent>
        </Card>
      </div>

      {/* Gallery Stats */}
      <Card>
        <CardHeader>
          <CardTitle>Gallery Statistics</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid gap-4 md:grid-cols-4">
            <div className="text-center">
              <div className="text-2xl font-bold text-blue-600">{galleryItems.length}</div>
              <p className="text-sm text-gray-600">Total Images</p>
            </div>
            <div className="text-center">
              <div className="text-2xl font-bold text-green-600">2</div>
              <p className="text-sm text-gray-600">Apartments</p>
            </div>
            <div className="text-center">
              <div className="text-2xl font-bold text-purple-600">0</div>
              <p className="text-sm text-gray-600">Hero Images</p>
            </div>
            <div className="text-center">
              <div className="text-2xl font-bold text-orange-600">0 MB</div>
              <p className="text-sm text-gray-600">Storage Used</p>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}