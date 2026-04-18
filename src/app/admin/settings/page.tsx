'use client'

import { useState, useEffect } from 'react'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { useRouter } from 'next/navigation'

interface Settings {
  theme_colors: {
    header_bg_left: string
    header_bg_right: string
    footer_color: string
  }
}

export default function AdminSettingsPage() {
  const [settings, setSettings] = useState<Settings>({
    theme_colors: {
      header_bg_left: '#10223f',
      header_bg_right: '#7c3aed',
      footer_color: '#10223f'
    }
  })
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const router = useRouter()

  useEffect(() => {
    fetchSettings()
  }, [])

  const fetchSettings = async () => {
    try {
      const response = await fetch('/api/admin/settings')
      if (response.ok) {
        const data = await response.json()
        setSettings({
          theme_colors: data.theme_colors || settings.theme_colors
        })
      }
    } catch (error) {
      console.error('Error fetching settings:', error)
    } finally {
      setLoading(false)
    }
  }

  const handleSave = async () => {
    setSaving(true)
    try {
      const response = await fetch('/api/admin/settings', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(settings)
      })

      if (response.ok) {
        alert('Settings saved successfully!')
        router.refresh()
      } else {
        alert('Failed to save settings')
      }
    } catch (error) {
      console.error('Error saving settings:', error)
      alert('Error saving settings')
    } finally {
      setSaving(false)
    }
  }

  const updateThemeColor = (key: keyof Settings['theme_colors'], value: string) => {
    setSettings({
      ...settings,
      theme_colors: {
        ...settings.theme_colors,
        [key]: value
      }
    })
  }

  if (loading) {
    return <div>Loading settings...</div>
  }

  return (
    <div className="space-y-8 py-8">
      <div className="animate-title">
        <h1 className="text-3xl font-bold text-gray-900">Settings</h1>
        <p className="text-gray-600 mt-2">
          Configure theme colors, logo settings, and other site preferences.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Theme Colors</CardTitle>
        </CardHeader>
        <CardContent className="space-y-6">
          <div className="grid gap-4 md:grid-cols-2">
            <div>
              <Label htmlFor="header_bg_left">Header Left Background</Label>
              <Input
                id="header_bg_left"
                type="color"
                value={settings.theme_colors.header_bg_left}
                onChange={(e) => updateThemeColor('header_bg_left', e.target.value)}
              />
            </div>
            <div>
              <Label htmlFor="header_bg_right">Header Right Background</Label>
              <Input
                id="header_bg_right"
                type="color"
                value={settings.theme_colors.header_bg_right}
                onChange={(e) => updateThemeColor('header_bg_right', e.target.value)}
              />
            </div>
            <div>
              <Label htmlFor="footer_color">Footer Color</Label>
              <Input
                id="footer_color"
                type="color"
                value={settings.theme_colors.footer_color}
                onChange={(e) => updateThemeColor('footer_color', e.target.value)}
              />
            </div>
          </div>
        </CardContent>
      </Card>


      <div className="flex justify-end">
        <Button onClick={handleSave} disabled={saving}>
          {saving ? 'Saving...' : 'Save Settings'}
        </Button>
      </div>
    </div>
  )
}
