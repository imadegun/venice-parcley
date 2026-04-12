'use client'

import { ReactNode, useState, useEffect } from 'react'
import { X } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from '@/components/ui/dialog'
import { Input } from '@/components/ui/input'
import { Textarea } from '@/components/ui/textarea'
import { Label } from '@/components/ui/label'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'

type FieldType = 'text' | 'number' | 'textarea' | 'select' | 'checkbox' | 'markdown'

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
}: DynamicFormProps) {
  const [values, setValues] = useState<Record<string, unknown>>({})

  useEffect(() => {
    if (initialValues) {
      setValues(initialValues)
    } else {
      setValues({})
    }
  }, [initialValues, isOpen])

  const handleChange = (name: string, value: unknown) => {
    setValues(prev => ({ ...prev, [name]: value }))
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
              <SelectValue placeholder={field.placeholder || 'Select...'} />
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

      default:
        return null
    }
  }

  return (
    <Dialog open={isOpen} onOpenChange={(open) => !open && onClose()}>
      <DialogContent className="max-w-lg">
        <DialogHeader>
          <DialogTitle className="flex justify-between items-center">
            <span>{title}</span>
            <Button variant="ghost" size="icon-sm" onClick={onClose}>
              <X className="w-4 h-4" />
            </Button>
          </DialogTitle>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="space-y-4">
          {fields.map((field) => (
            <div key={field.name} className="space-y-1.5">
              <Label>
                {field.label}
                {field.required && <span className="text-destructive ml-0.5">*</span>}
              </Label>
              {renderField(field)}
            </div>
          ))}

          <DialogFooter className="pt-4">
            <Button variant="ghost" type="button" onClick={onClose}>
              Cancel
            </Button>
            <Button type="submit" disabled={loading}>
              {loading ? 'Saving...' : submitText}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  )
}
