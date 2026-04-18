'use client'

import { ReactNode } from 'react'
import {
  Edit,
  Trash2,
  Plus,
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { AdminPagination } from '@/components/admin/pagination'

interface Column<T> {
  key: keyof T | string
  label: string
  render?: (item: T) => ReactNode
}

interface DataTableProps<T> {
  data: T[]
  columns: Column<T>[]
  onAdd?: () => void
  onEdit?: (item: T) => void
  onDelete?: (item: T) => void
  pagination?: {
    currentPage: number
    totalItems: number
    itemsPerPage: number
    onPageChange: (page: number) => void
  }
  addButtonText?: string
  emptyMessage?: string
}

export function DataTable<T>({
  data,
  columns,
  onAdd,
  onEdit,
  onDelete,
  pagination,
  addButtonText = 'Add Item',
  emptyMessage = 'No items found',
}: DataTableProps<T>) {
  const hasActions = onEdit || onDelete
  const hasPagination = !!pagination

  return (
    <div className="space-y-4">
      {onAdd && (
        <div className="flex justify-end">
          <Button onClick={onAdd}>
            <Plus className="w-4 h-4 mr-2" />
            {addButtonText}
          </Button>
        </div>
      )}

      <div className="overflow-x-auto border rounded-lg">
        <table className="w-full text-sm">
          <thead>
            <tr className="border-b bg-muted/50">
              {columns.map((col) => (
                <th
                  key={col.key as string}
                  className="px-4 py-3 text-left font-medium text-muted-foreground"
                >
                  {col.label}
                </th>
              ))}
              {hasActions && (
                <th className="px-4 py-3 text-right font-medium text-muted-foreground w-[100px]">
                  Actions
                </th>
              )}
            </tr>
          </thead>
          <tbody>
            {data.length === 0 ? (
              <tr>
                <td
                  colSpan={columns.length + (hasActions ? 1 : 0)}
                  className="px-4 py-12 text-center text-muted-foreground"
                >
                  {emptyMessage}
                </td>
              </tr>
            ) : (
              data.map((item, index) => (
                <tr key={index} className="border-b last:border-0 hover:bg-muted/50">
                  {columns.map((col) => (
                    <td key={col.key as string} className="px-4 py-3">
                      {col.render
                        ? col.render(item)
                        : String(item[col.key as keyof T] ?? '')}
                    </td>
                  ))}
                  {hasActions && (
                    <td className="px-4 py-3 text-right">
                      <div className="flex justify-end gap-1">
                        {onEdit && (
                          <Button
                            variant="ghost"
                            size="icon"
                            onClick={() => onEdit(item)}
                            className="h-8 w-8"
                          >
                            <Edit className="w-4 h-4" />
                          </Button>
                        )}
                        {onDelete && (
                          <Button
                            variant="ghost"
                            size="icon"
                            onClick={() => onDelete(item)}
                            className="h-8 w-8 text-destructive hover:text-destructive"
                          >
                            <Trash2 className="w-4 h-4" />
                          </Button>
                        )}
                      </div>
                    </td>
                  )}
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>

      {hasPagination && pagination && (
        <AdminPagination
          currentPage={pagination.currentPage}
          totalPages={Math.ceil(pagination.totalItems / pagination.itemsPerPage)}
          totalItems={pagination.totalItems}
          itemsPerPage={pagination.itemsPerPage}
          onPageChange={pagination.onPageChange}
        />
      )}
    </div>
  )
}
