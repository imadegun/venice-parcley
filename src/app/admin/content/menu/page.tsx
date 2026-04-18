'use client'

import { useState, useEffect } from 'react'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'
import { Plus, Edit, Trash2 } from 'lucide-react'

interface MenuItem {
  id: string
  label: string
  href: string
  is_active: boolean
  sort_order: number
}

// Convert text to URL-friendly slug
const slugify = (text: string): string => {
  return text
    .toLowerCase()
    .trim()
    .replace(/\s+/g, '-')           // Replace spaces with hyphens
    .replace(/[^a-z0-9-]/g, '')     // Remove all non-alphanumeric except hyphens
    .replace(/-+/g, '-')            // Replace multiple hyphens with single
    .replace(/^-+|-+$/g, '')        // Trim hyphens from start/end
}

export default function MenuManagement() {
  const [menuItems, setMenuItems] = useState<MenuItem[]>([])
  const [loading, setLoading] = useState(true)
  const [dialogOpen, setDialogOpen] = useState(false)
  const [editingItem, setEditingItem] = useState<MenuItem | null>(null)
  const [formData, setFormData] = useState({
    label: '',
    href: '',
    is_active: true,
    sort_order: 0
  })
  const [hrefTouched, setHrefTouched] = useState(false) // Track if user manually edited href
  useEffect(() => {
    fetchMenuItems()
  }, [])

  const fetchMenuItems = async () => {
    try {
      const response = await fetch('/api/admin/menu')
      if (response.ok) {
        const data = await response.json()
        setMenuItems(data)
      }
    } catch (error) {
      console.error('Error fetching menu items:', error)
    } finally {
      setLoading(false)
    }
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()

    try {
      const url = editingItem ? `/api/admin/menu/${editingItem.id}` : '/api/admin/menu'
      const method = editingItem ? 'PUT' : 'POST'

      const response = await fetch(url, {
        method,
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData)
      })

      if (response.ok) {
        await fetchMenuItems()
        setDialogOpen(false)
        resetForm()
      }
    } catch (error) {
      console.error('Error saving menu item:', error)
    }
  }

  const handleDelete = async (id: string) => {
    if (!confirm('Are you sure you want to delete this menu item?')) return

    try {
      const response = await fetch(`/api/admin/menu/${id}`, {
        method: 'DELETE'
      })

      if (response.ok) {
        await fetchMenuItems()
      }
    } catch (error) {
      console.error('Error deleting menu item:', error)
    }
  }

  const resetForm = () => {
    setFormData({ label: '', href: '', is_active: true, sort_order: 0 })
    setEditingItem(null)
    setHrefTouched(false)
  }

  const openEditDialog = (item: MenuItem) => {
    setEditingItem(item)
    setFormData({
      label: item.label,
      href: item.href,
      is_active: item.is_active,
      sort_order: item.sort_order
    })
    setHrefTouched(true) // Existing href is considered manually set
    setDialogOpen(true)
  }

  if (loading) {
    return <div>Loading menu items...</div>
  }

  return (
    <div className="space-y-8 py-8">
      <div className="flex justify-between items-center animate-title">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Menu Management</h1>
          <p className="text-gray-600 mt-2">
            Add, edit, and organize navigation menu items.
          </p>
        </div>

        <Dialog
          open={dialogOpen}
          onOpenChange={(open) => {
            setDialogOpen(open)
            if (!open) {
              // Reset form state when dialog closes (cancel or submit)
              resetForm()
            }
          }}
        >
          <DialogTrigger className="inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:opacity-50 disabled:pointer-events-none ring-offset-background bg-primary text-primary-foreground hover:bg-primary/90 h-10 py-2 px-4">
            <Plus className="w-4 h-4 mr-2" />
            Add Menu Item
          </DialogTrigger>
          <DialogContent>
            <DialogHeader>
              <DialogTitle>
                {editingItem ? 'Edit Menu Item' : 'Add Menu Item'}
              </DialogTitle>
            </DialogHeader>
            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <Label htmlFor="label">Label</Label>
                <Input
                  id="label"
                  value={formData.label}
                  onChange={(e) => {
                    const newLabel = e.target.value
                    // Auto-generate href only if user hasn't manually edited it
                    const newHref = hrefTouched ? formData.href : slugify(newLabel)
                    setFormData({ ...formData, label: newLabel, href: newHref })
                  }}
                  required
                />
              </div>
              <div>
                <Label htmlFor="href">URL</Label>
                <Input
                  id="href"
                  value={formData.href}
                  onChange={(e) => {
                    setFormData({ ...formData, href: e.target.value })
                    setHrefTouched(true) // Mark as manually edited
                  }}
                  onFocus={() => setHrefTouched(true)}
                  required
                />
              </div>
              <div className="flex items-center space-x-2">
                <input
                  type="checkbox"
                  id="is_active"
                  checked={formData.is_active}
                  onChange={(e) => setFormData({ ...formData, is_active: e.target.checked })}
                  className="w-4 h-4"
                />
                <Label htmlFor="is_active">Active</Label>
              </div>
              <div>
                <Label htmlFor="sort_order">Sort Order</Label>
                <Input
                  id="sort_order"
                  type="number"
                  value={formData.sort_order}
                  onChange={(e) => setFormData({ ...formData, sort_order: parseInt(e.target.value) })}
                />
              </div>
              <div className="flex justify-end space-x-2">
                <Button type="button" variant="outline" onClick={() => setDialogOpen(false)}>
                  Cancel
                </Button>
                <Button type="submit">
                  {editingItem ? 'Update' : 'Create'}
                </Button>
              </div>
            </form>
          </DialogContent>
        </Dialog>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Menu Items</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {menuItems.map((item) => (
              <div key={item.id} className="flex items-center justify-between p-4 border rounded-lg">
                <div>
                  <div className="font-medium">{item.label}</div>
                  <div className="text-sm text-gray-500">{item.href}</div>
                  <div className="text-xs text-gray-400">Order: {item.sort_order}</div>
                </div>
                <div className="flex items-center space-x-2">
                  <span className={`px-2 py-1 text-xs rounded ${
                    item.is_active ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'
                  }`}>
                    {item.is_active ? 'Active' : 'Inactive'}
                  </span>
                  <Button variant="outline" size="sm" onClick={() => openEditDialog(item)}>
                    <Edit className="w-4 h-4" />
                  </Button>
                  <Button variant="outline" size="sm" onClick={() => handleDelete(item.id)}>
                    <Trash2 className="w-4 h-4" />
                  </Button>
                </div>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>
    </div>
  )
}