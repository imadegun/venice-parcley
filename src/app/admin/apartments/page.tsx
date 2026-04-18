'use client'

import { useEffect, useState } from 'react'
import { createClient } from '@/lib/supabase'
import { createApartment, deleteApartment, updateApartment } from './actions'
import { DataTable } from '@/components/admin/data-table'
import { DynamicForm } from '@/components/admin/dynamic-form'
import { ConfirmDialog } from '@/components/admin/confirm-dialog'
import { ImageUploader } from '@/components/admin/image-uploader'



interface Apartment {
  id: string
  name: string
  slug: string
  category: string
  description: string
  short_description: string
  base_price_cents: number
  max_guests: number
  bedrooms: number
  size_sqm: number
  amenities: string[]
  gallery_images: string[]
  image_url: string
}

export default function AdminApartmentsPage() {
  const [apartments, setApartments] = useState<Apartment[]>([])
  const [loading, setLoading] = useState(true)
  const [currentPage, setCurrentPage] = useState(1)
  const itemsPerPage = 10

  // Form state
  const [showForm, setShowForm] = useState(false)
  const [editItem, setEditItem] = useState<Apartment | null>(null)
  const [formLoading, setFormLoading] = useState(false)

  // Delete confirmation state
  const [showDeleteConfirm, setShowDeleteConfirm] = useState(false)
  const [deleteItem, setDeleteItem] = useState<Apartment | null>(null)
  const [deleteLoading, setDeleteLoading] = useState(false)

  useEffect(() => {
    loadApartments()
  }, [])

  async function loadApartments() {
    setLoading(true)
    const supabase = createClient()
    const { data } = await supabase
      .from('apartments')
      .select('*')
      .order('created_at', { ascending: false })
    setApartments(data || [])
    setLoading(false)
  }

  const handleAdd = () => {
    setEditItem(null)
    setShowForm(true)
  }

  const handleEdit = (item: Apartment) => {
    setEditItem(item)
    setShowForm(true)
  }

  const handleDelete = (item: Apartment) => {
    setDeleteItem(item)
    setShowDeleteConfirm(true)
  }

  const handleFormSubmit = async (values: Record<string, unknown>) => {
    setFormLoading(true)
    try {
      if (editItem) {
        await updateApartment({ id: editItem.id, ...values })
      } else {
        await createApartment(values)
      }
      await loadApartments()
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
      await deleteApartment(deleteItem.id)
      await loadApartments()
      setShowDeleteConfirm(false)
      setDeleteItem(null)
    } finally {
      setDeleteLoading(false)
    }
  }

  const formFields = [
    { name: 'name', label: 'Name', type: 'text' as const, required: true },
    { name: 'slug', label: 'Slug (auto-generated)', type: 'text' as const, required: true, disabled: true },
    { name: 'short_description', label: 'Short Description', type: 'text' as const },
    { name: 'description', label: 'Description', type: 'markdown' as const, required: true },
    { name: 'base_price_cents', label: 'Base Price (cents)', type: 'number' as const, required: true },
    { name: 'max_guests', label: 'Max Guests', type: 'number' as const, required: true },
    { name: 'bedrooms', label: 'Bedrooms', type: 'number' as const, required: true },
    { name: 'amenities', label: 'Amenities (comma separated)', type: 'text' as const },
    { name: 'unified_images', label: 'Apartment Images', type: 'unified-images' as const, required: true },
  ]

  const tableColumns = [
    { key: 'name', label: 'Name' },
    { key: 'max_guests', label: 'Guests' },
    { key: 'base_price_cents', label: 'Price', render: (item: Apartment) => `$${(item.base_price_cents / 100).toFixed(2)}` },
    { key: 'size_sqm', label: 'Size', render: (item: Apartment) => `${item.size_sqm} m²` },
  ]

  if (loading) {
    return <div className="p-8">Loading apartments...</div>
  }

  return (
    <div className="space-y-8 py-8">
      <div className="animate-title">
        <h1 className="text-3xl font-semibold text-gray-900">Apartments Management</h1>
        <p className="text-gray-600">Create, update, and delete apartment inventory.</p>
      </div>

      <DataTable
        data={apartments}
        columns={tableColumns}
        onAdd={handleAdd}
        onEdit={handleEdit}
        onDelete={handleDelete}
        addButtonText="Add Apartment"
        emptyMessage="No apartments found. Click Add Apartment to create your first one."
        pagination={{
          currentPage,
          totalItems: apartments.length,
          itemsPerPage,
          onPageChange: setCurrentPage,
        }}
      />

      <DynamicForm
        isOpen={showForm}
        onClose={() => setShowForm(false)}
        onSubmit={handleFormSubmit}
        fields={formFields}
        initialValues={editItem ? {
          ...editItem,
          amenities: editItem.amenities?.join(', '),
          unified_images: {
            images: editItem.gallery_images || [],
            mainImageIndex: Math.max(
              0,
              editItem.gallery_images?.findIndex((img) => img === editItem.image_url) ?? 0
            )
          },
        } : undefined}
        title={editItem ? 'Edit Apartment' : 'Add New Apartment'}
        submitText={editItem ? 'Update Apartment' : 'Create Apartment'}
        loading={formLoading}
      />

      <ConfirmDialog
        open={showDeleteConfirm}
        onOpenChange={setShowDeleteConfirm}
        onConfirm={handleConfirmDelete}
        title="Delete Apartment"
        description={`Are you sure you want to delete "${deleteItem?.name}"? This action cannot be undone.`}
        confirmText="Delete Apartment"
        isLoading={deleteLoading}
        variant="destructive"
      />
    </div>
  )
}
