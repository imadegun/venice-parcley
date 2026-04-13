import { z } from 'zod'
import { createClient } from './supabase'

const supabase = createClient()

// Pagination types
export interface PaginationParams {
  page: number
  limit: number
  search?: string
  sortBy?: string
  sortOrder?: 'asc' | 'desc'
}

export interface PaginatedResult<T> {
  data: T[]
  total: number
  page: number
  limit: number
  totalPages: number
}

// Generic CRUD Service
export class BaseCRUDService<T, TInsert, TUpdate> {
  constructor(
    protected tableName: string,
    protected primaryKey: string = 'id',
    protected defaultSort: { field: string; order: 'asc' | 'desc' } = { field: 'created_at', order: 'desc' }
  ) {}

  async findAll(params: PaginationParams): Promise<PaginatedResult<T>> {
    const { page, limit, search, sortBy, sortOrder } = params
    
    let query = supabase.from(this.tableName).select('*', { count: 'exact' })
    
    // Apply search if provided
    if (search) {
      query = query.ilike('name', `%${search}%`)
    }
    
    // Apply sorting
    const sortField = sortBy || this.defaultSort.field
    const sortDirection = sortOrder || this.defaultSort.order
    query = query.order(sortField, { ascending: sortDirection === 'asc' })
    
    // Apply pagination
    const from = (page - 1) * limit
    const to = from + limit - 1
    query = query.range(from, to)
    
    const { data, error, count } = await query
    
    if (error) throw error
    
    return {
      data: data as T[],
      total: count || 0,
      page,
      limit,
      totalPages: Math.ceil((count || 0) / limit)
    }
  }

  async findById(id: string): Promise<T | null> {
    const { data, error } = await supabase
      .from(this.tableName)
      .select('*')
      .eq(this.primaryKey, id)
      .single()
    
    if (error) throw error
    return data as T
  }

  async create(data: TInsert): Promise<T> {
    const { data: result, error } = await supabase
      .from(this.tableName)
      .insert(data as any)
      .select()
      .single()
    
    if (error) throw error
    return result as T
  }

  async update(id: string, data: TUpdate): Promise<T> {
    const { data: result, error } = await supabase
      .from(this.tableName)
      .update(data as any)
      .eq(this.primaryKey, id)
      .select()
      .single()
    
    if (error) throw error
    return result as T
  }

  async delete(id: string): Promise<void> {
    const { error } = await supabase
      .from(this.tableName)
      .delete()
      .eq(this.primaryKey, id)
    
    if (error) throw error
  }
}

// Validation helper
export function validateSchema<T>(schema: z.ZodSchema<T>, data: unknown): T {
  const result = schema.safeParse(data)
  
  if (!result.success) {
    const errors = result.error.issues.map(issue => ({
      field: issue.path.join('.'),
      message: issue.message
    }))
    
    const error = new Error('Validation failed') as Error & { validationErrors: typeof errors }
    error.validationErrors = errors
    throw error
  }
  
  return result.data
}
