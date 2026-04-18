'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Badge } from '@/components/ui/badge'
import { Upload, Image as ImageIcon, Trash2 } from 'lucide-react'
import { DataTable } from '@/components/admin/data-table'
import { DynamicForm } from '@/components/admin/dynamic-form'
import { ConfirmDialog } from '@/components/admin/confirm-dialog'

export default function GalleryManagement() {
  const [galleryItems, setGalleryItems] = useState<any[]>([])
  const [loading, setLoading] = useState(true)
  const [currentPage, setCurrentPage] = useState(1)
  const itemsPerPage = 10

  // Form state
  const [showForm, setShowForm] = useState(false)
  const [editItem, setEditItem] = useState<any | null>(null)
  const [formLoading, setFormLoading] = useState(false)

  // Delete confirmation state
  const [showDeleteConfirm, setShowDeleteConfirm] = useState(false)
  const [deleteItem, setDeleteItem] = useState<any | null>(null)
  const [deleteLoading, setDeleteLoading] = useState(false)

  useEffect(() => {
    loadGalleryItems()
  }, [])

  async function loadGalleryItems() {
    setLoading(true)
    const supabase = createClient()
    const { data } = await supabase
      .from('gallery')
      .select('*')
      .order('created_at', { ascending: false })
    setGalleryItems(data || [])
    setLoading(false)
  }

  const handleAdd = () => {
    setEditItem(null)
    setShowForm(true)
  }

  const handleEdit = (item: any) => {
    setEditItem(item)
    setShowForm(true)
  }

  const handleDelete = (item: any) => {
    setDeleteItem(item)
    setShowDeleteConfirm(true)
  }

  const handleFormSubmit = async (values: Record<string, unknown>) => {
    setFormLoading(true)
    try {
      const supabase = createClient()
      if (editItem) {
        await supabase.from('gallery').update(values).eq('id', editItem.id)
      } else {
        await supabase.from('gallery').insert(values)
      }
      await loadGalleryItems()
      setShowForm(false)
      setEditItem(null)
    } finally {
      setFormLoading(false)
    }
  }

  const handleConfirmDelete = async () => {
    if (!deleteItem) return
    setDeleteLoading(true)
    try {
      const supabase = createClient()
      await supabase.from('gallery').delete().eq('id', deleteItem.id)
      await loadGalleryItems()
      setShowDeleteConfirm(false)
      setDeleteItem(null)
    } finally {
      setDeleteLoading(false)
    }
  }

  const formFields = [
    { name: 'name', label: 'Image Name', type: 'text' as const, required: true },
    { name: 'url', label: 'Image URL', type: 'text' as const, required: true },
    { name: 'type', label: 'Category', type: 'select' as const, options: [
      { value: 'apartment', label: 'Apartment' },
      { value: 'hero', label: 'Hero' },
      { value: 'general', label: 'General' }
    ], required: true },
  ]

  const tableColumns = [
    { key: 'name', label: 'Name' },
    { key: 'type', label: 'Category' },
    { key: 'url', label: 'Image URL', render: (item: any) => <span className="text-xs truncate max-w-[200px]">{item.url}</span> },
  ]

  if (loading) {
    return <div className="p-8">Loading gallery items...</div>
  }

  return (
    <div className="space-y-8 py-8">
      <div className="flex items-center justify-between animate-title">
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

      <DataTable
        data={galleryItems}
        columns={tableColumns}
        onAdd={handleAdd}
        onEdit={handleEdit}
        onDelete={handleDelete}
        addButtonText="Add Image"
        emptyMessage="No gallery images found. Click Add Image to upload your first one."
        pagination={{
          currentPage,
          totalItems: galleryItems.length,
          itemsPerPage,
          onPageChange: setCurrentPage,
        }}
      />

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
                <span>Uploaded {item.created_at || new Date().toISOString().split('T')[0]}</span>
                <Button variant="ghost" size="sm" className="text-red-600 hover:text-red-700" onClick={() => handleDelete(item)}>
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
              <div className="text-2xl font-bold text-green-600">{galleryItems.filter(i => i.type === 'apartment').length}</div>
              <p className="text-sm text-gray-600">Apartments</p>
            </div>
            <div className="text-center">
              <div className="text-2xl font-bold text-purple-600">{galleryItems.filter(i => i.type === 'hero').length}</div>
              <p className="text-sm text-gray-600">Hero Images</p>
            </div>
            <div className="text-center">
              <div className="text-2xl font-bold text-orange-600">{(galleryItems.length * 0.2).toFixed(1)} MB</div>
              <p className="text-sm text-gray-600">Storage Used</p>
            </div>
          </div>
        </CardContent>
      </Card>

      <DynamicForm
        isOpen={showForm}
        onClose={() => setShowForm(false)}
        onSubmit={handleFormSubmit}
        fields={formFields}
        initialValues={editItem || undefined}
        title={editItem ? 'Edit Gallery Image' : 'Add New Gallery Image'}
        submitText={editItem ? 'Update Image' : 'Add Image'}
        loading={formLoading}
      />

      <ConfirmDialog
        open={showDeleteConfirm}
        onOpenChange={setShowDeleteConfirm}
        onConfirm={handleConfirmDelete}
        title="Delete Gallery Image"
        description={`Are you sure you want to delete "${deleteItem?.name}"? This action cannot be undone.`}
        confirmText="Delete Image"
        isLoading={deleteLoading}
        variant="destructive"
      />
    </div>
  )
}
