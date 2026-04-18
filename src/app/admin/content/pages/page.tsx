'use client'

import { useState, useEffect } from 'react'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog'
import { Textarea } from '@/components/ui/textarea'
import { Label } from '@/components/ui/label'
import { Edit } from 'lucide-react'

interface MenuItem {
  id: string
  label: string
  href: string
  is_active: boolean
  sort_order: number
  content?: string | null
  map_embed?: string | null
}

export default function MenuPagesManagement() {
  const [menuItems, setMenuItems] = useState<MenuItem[]>([])
  const [loading, setLoading] = useState(true)
  const [dialogOpen, setDialogOpen] = useState(false)
  const [selectedItem, setSelectedItem] = useState<MenuItem | null>(null)
  const [content, setContent] = useState('')
  const [mapEmbed, setMapEmbed] = useState('')

  useEffect(() => {
    fetchMenuItems()
  }, [])

  const fetchMenuItems = async () => {
    try {
      const response = await fetch('/api/admin/menu')
      if (response.ok) {
        const data = await response.json()
        // Filter out system pages that should not be edited here
        const nonEditablePaths = ['/apartments', '/login', '/register', '/admin']
        const editableItems = data.filter((item: MenuItem) =>
          item.is_active && !nonEditablePaths.includes(item.href)
        )
        setMenuItems(editableItems)
      }
    } catch (error) {
      console.error('Error fetching menu items:', error)
    } finally {
      setLoading(false)
    }
  }

  const openEditContent = (item: MenuItem) => {
    setSelectedItem(item)
    setContent(item.content || '')
    setMapEmbed(item.map_embed || '')
    setDialogOpen(true)
  }

  const saveContent = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!selectedItem) return

    try {
      const response = await fetch(`/api/admin/menu/${selectedItem.id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          label: selectedItem.label,
          href: selectedItem.href,
          is_active: selectedItem.is_active,
          sort_order: selectedItem.sort_order,
          content,
          map_embed: mapEmbed
        })
      })

      if (response.ok) {
        await fetchMenuItems()
        setDialogOpen(false)
        setSelectedItem(null)
        setContent('')
        setMapEmbed('')
      }
    } catch (error) {
      console.error('Error saving page content:', error)
    }
  }

  if (loading) {
    return <div>Loading menu items...</div>
  }

  return (
    <div className="space-y-8 py-8">
      <div className="animate-title">
        <h1 className="text-3xl font-bold text-gray-900">Menu Page Content</h1>
        <p className="text-gray-600 mt-2">
          Manage page content for each navigation menu item. Edit rich text for pages like About, Contact, etc.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Pages</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {menuItems.map((item) => (
              <div key={item.id} className="flex items-center justify-between p-4 border rounded-lg">
                <div>
                  <div className="font-medium">{item.label}</div>
                  <div className="text-sm text-gray-500">URL: {item.href}</div>
                  <div className="flex flex-wrap gap-2 mt-1">
                    {item.content && (
                      <span className="text-xs px-2 py-0.5 bg-green-100 text-green-700 rounded">
                        Content ✓
                      </span>
                    )}
                    {item.map_embed && (
                      <span className="text-xs px-2 py-0.5 bg-blue-100 text-blue-700 rounded">
                        Map ✓
                      </span>
                    )}
                  </div>
                </div>
                <div className="flex items-center space-x-2">
                  <Button variant="outline" size="sm" onClick={() => openEditContent(item)}>
                    <Edit className="w-4 h-4 mr-2" />
                    Edit Content
                  </Button>
                </div>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>

      <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
        <DialogContent className="max-w-2xl">
          <DialogHeader>
            <DialogTitle>
              Edit Page Content: {selectedItem?.label}
            </DialogTitle>
          </DialogHeader>
          <form onSubmit={saveContent} className="space-y-4">
            <div>
              <Label htmlFor="content">Page Content (HTML)</Label>
              <Textarea
                id="content"
                value={content}
                onChange={(e) => setContent(e.target.value)}
                placeholder="Enter page content... Supports HTML tags like <p>, <strong>, <ul>, <li>, etc."
                className="min-h-[200px] mt-2"
              />
              <p className="text-xs text-gray-500 mt-1">
                Supports HTML formatting. Leave empty if no content needed.
              </p>
            </div>

            <div>
              <Label htmlFor="map_embed">Location Map (Optional)</Label>
              <Textarea
                id="map_embed"
                value={mapEmbed}
                onChange={(e) => setMapEmbed(e.target.value)}
                placeholder="Paste Google Maps embed iframe code..."
                className="min-h-[100px] mt-2 font-mono text-sm"
              />
              <p className="text-xs text-gray-500 mt-1">
                Paste a Google Maps embed iframe. The map will display above the page content (useful for Contact page).
              </p>
            </div>

            <div className="flex justify-end space-x-2">
              <Button type="button" variant="outline" onClick={() => setDialogOpen(false)}>
                Cancel
              </Button>
              <Button type="submit">
                Save Content
              </Button>
            </div>
          </form>
        </DialogContent>
      </Dialog>
    </div>
  )
}
