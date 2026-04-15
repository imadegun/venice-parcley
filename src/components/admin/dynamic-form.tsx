'use client'

import { useState, useEffect } from 'react'
import { X } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from '@/components/ui/dialog'
import { Input } from '@/components/ui/input'
import { Textarea } from '@/components/ui/textarea'
import { Label } from '@/components/ui/label'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { ImageUploader } from './image-uploader'
import { UnifiedImageManager } from './unified-image-manager'

type FieldType = 'text' | 'number' | 'textarea' | 'select' | 'checkbox' | 'markdown' | 'images' | 'unified-images'

interface Field {
  name: string
  label: string
  type: FieldType
  placeholder?: string
  required?: boolean
  options?: { value: string; label: string }[]
  disabled?: boolean
}

interface DynamicFormProps {
  isOpen: boolean
  onClose: () => void
  onSubmit: (values: Record<string, unknown>) => Promise<void> | void
  fields: Field[]
  initialValues?: Record<string, unknown>
  title?: string
  submitText?: string
  loading?: boolean
  editItem?: Record<string, unknown>
}

export function DynamicForm({
  isOpen,
  onClose,
  onSubmit,
  fields,
  initialValues = {},
  title = 'Add Item',
  submitText = 'Save',
  loading = false,
  editItem,
}: DynamicFormProps) {
  const isEditing = Boolean(initialValues && Object.keys(initialValues).length > 0)
  const [values, setValues] = useState<Record<string, unknown>>({})

  const toSlug = (input: string) =>
    input
      .toLowerCase()
      .trim()
      .replace(/[^a-z0-9\s-]/g, '')
      .replace(/\s+/g, '-')
      .replace(/-+/g, '-')

  useEffect(() => {
    if (isOpen && initialValues) {
      setValues({...initialValues})
    } else if (isOpen) {
      setValues({})
    }
  }, [initialValues, isOpen])

  const handleChange = (name: string, value: unknown) => {
    setValues(prev => {
      const next = { ...prev, [name]: value }

      const hasNameField = fields.some((field) => field.name === 'name')
      const hasSlugField = fields.some((field) => field.name === 'slug')

      if (name === 'name' && hasNameField && hasSlugField) {
        next.slug = toSlug(String(value ?? ''))
      }

      return next
    })
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    await onSubmit(values)
  }

  const renderField = (field: Field) => {
    const value = values[field.name]

    switch (field.type) {
      case 'text':
      case 'number':
        return (
          <Input
            type={field.type}
            placeholder={field.placeholder}
            value={String(value ?? '')}
            onChange={(e) => handleChange(field.name, e.target.value)}
            disabled={field.disabled}
          />
        )

      case 'textarea':
        return (
          <Textarea
            placeholder={field.placeholder}
            value={String(value ?? '')}
            onChange={(e) => handleChange(field.name, e.target.value)}
            rows={5}
            disabled={field.disabled}
          />
        )

      case 'markdown':
        return (
          <Textarea
            placeholder={field.placeholder}
            value={String(value ?? '')}
            onChange={(e) => handleChange(field.name, e.target.value)}
            rows={8}
            disabled={field.disabled}
            className="font-mono text-sm"
          />
        )

      case 'checkbox':
        return (
          <input
            type="checkbox"
            checked={Boolean(value)}
            onChange={(e) => handleChange(field.name, e.target.checked)}
            disabled={field.disabled}
            className="h-4 w-4 rounded border-gray-300"
          />
        )

      case 'select':
        return (
          <Select
            value={String(value ?? '')}
            onValueChange={(val) => handleChange(field.name, val)}
            disabled={field.disabled}
          >
              <SelectTrigger>
                <SelectValue>{field.placeholder || 'Select...'}</SelectValue>
              </SelectTrigger>
            <SelectContent>
              {field.options?.map((opt) => (
                <SelectItem key={opt.value} value={opt.value}>
                  {opt.label}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        )

      case 'images':
        return (
          <ImageUploader
            value={Array.isArray(value) ? value : []}
            onChange={(urls) => handleChange(field.name, urls)}
          />
        )

      case 'unified-images':
        return (
          <UnifiedImageManager
            value={value as { images: string[], mainImageIndex: number } || { images: [], mainImageIndex: 0 }}
            slug={String(values.slug ?? values.name ?? '')}
            onChange={(data) => handleChange(field.name, data)}
          />
        )

      default:
        return null
    }
  }

  return (
    <Dialog open={isOpen} onOpenChange={(open) => !open && onClose()}>
      <DialogContent className="w-[80vw] !max-w-[80vw] max-h-[80vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle>{title}</DialogTitle>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="space-y-8">
          {/* Header */}
          <div className="pb-6 border-b">
            <h2 className="text-2xl font-semibold text-gray-900">{title}</h2>
            <p className="text-sm text-gray-600 mt-2">Fill out the information below to {editItem ? 'update' : 'create'} this item.</p>
          </div>

          {/* Form Content */}
          <div className="space-y-8">
            {/* Basic Information */}
            <div className="bg-gray-50 rounded-lg p-6">
              <div className="flex items-center gap-3 mb-4">
                <div className="w-1 h-8 bg-blue-500 rounded-full"></div>
                <div>
                  <h3 className="text-lg font-semibold text-gray-900">Basic Information</h3>
                  <p className="text-sm text-gray-600">Core details about the apartment</p>
                </div>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                {fields.slice(0, 4).map((field) => (
                  <div key={field.name} className="space-y-2">
                    <Label className="text-sm font-medium text-gray-700">
                      {field.label}
                      {field.required && <span className="text-red-500 ml-1">*</span>}
                    </Label>
                    {renderField(field)}
                  </div>
                ))}
              </div>

              <div className="mt-6">
                {fields.slice(4, 5).map((field) => (
                  <div key={field.name} className="space-y-2">
                    <Label className="text-sm font-medium text-gray-700">
                      {field.label}
                      {field.required && <span className="text-red-500 ml-1">*</span>}
                    </Label>
                    {renderField(field)}
                  </div>
                ))}
              </div>
            </div>

            {/* Details & Amenities */}
            <div className="bg-gray-50 rounded-lg p-6">
              <div className="flex items-center gap-3 mb-4">
                <div className="w-1 h-8 bg-green-500 rounded-full"></div>
                <div>
                  <h3 className="text-lg font-semibold text-gray-900">Details & Amenities</h3>
                  <p className="text-sm text-gray-600">Additional features and specifications</p>
                </div>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                {fields.slice(5, 11).map((field) => (
                  <div key={field.name} className="space-y-2">
                    <Label className="text-sm font-medium text-gray-700">
                      {field.label}
                      {field.required && <span className="text-red-500 ml-1">*</span>}
                    </Label>
                    {renderField(field)}
                  </div>
                ))}
              </div>
            </div>

            {/* Images Section */}
            {fields.slice(11).length > 0 && (
              <div className="bg-gray-50 rounded-lg p-6">
                <div className="flex items-center gap-3 mb-4">
                  <div className="w-1 h-8 bg-purple-500 rounded-full"></div>
                  <div>
                    <h3 className="text-lg font-semibold text-gray-900">Images & Media</h3>
                    <p className="text-sm text-gray-600">Upload images and visual content</p>
                  </div>
                </div>

                <div className="space-y-6">
                  {fields.slice(11).map((field) => (
                    <div key={field.name} className="space-y-2">
                      <Label className="text-sm font-medium text-gray-700">
                        {field.label}
                        {field.required && <span className="text-red-500 ml-1">*</span>}
                      </Label>
                      {renderField(field)}
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>

          {/* Form Actions */}
          <div className="flex justify-end gap-3 pt-6 border-t bg-white">
            <Button variant="outline" type="button" onClick={onClose} disabled={loading}>
              Cancel
            </Button>
            <Button type="submit" disabled={loading}>
              {loading ? 'Saving...' : submitText}
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  )
}
