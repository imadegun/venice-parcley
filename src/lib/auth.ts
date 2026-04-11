import { redirect } from 'next/navigation'
import { createServerSupabaseClient } from '@/lib/supabase'
import type { Database } from '@/types/database'

type UserRole = 'user' | 'admin' | 'administrator'

export async function requireAuth() {
  const supabase = createServerSupabaseClient()
  const { data: { user }, error } = await supabase.auth.getUser()

  if (error || !user) {
    redirect('/login')
  }

  return user
}

export async function requireRole(requiredRoles: UserRole[] | UserRole = 'user') {
  const user = await requireAuth()
  const userRole = await getUserRole(user.id)

  // Convert single role to array for consistent handling
  const roleArray = Array.isArray(requiredRoles) ? requiredRoles : [requiredRoles]

  // Check if user has required role
  if (!roleArray.includes(userRole)) {
    // Redirect based on user's actual role
    if (userRole === 'user') {
      redirect('/')
    } else {
      redirect('/admin')
    }
  }

  return user
}

export async function getCurrentUser() {
  const supabase = createServerSupabaseClient()
  const { data: { user } } = await supabase.auth.getUser()
  return user
}

export async function getUserRole(userId: string): Promise<UserRole> {
  const supabase = createServerSupabaseClient()

  try {
    const { data: profile, error } = await supabase
      .from('user_profiles')
      .select('role')
      .eq('user_id', userId)
      .single()

    if (error || !profile) {
      // Default to 'user' role if profile doesn't exist
      return 'user'
    }

    return profile.role as UserRole
  } catch {
    return 'user'
  }
}

export async function getUserProfile(userId: string) {
  const supabase = createServerSupabaseClient()

  const { data: profile, error } = await supabase
    .from('user_profiles')
    .select('*')
    .eq('user_id', userId)
    .single()

  if (error) {
    throw new Error('Failed to fetch user profile')
  }

  return profile
}

export async function updateUserRole(userId: string, role: UserRole) {
  const supabase = createServerSupabaseClient()

  const { error } = await supabase
    .from('user_profiles')
    .upsert({
      user_id: userId,
      role: role,
      updated_at: new Date().toISOString()
    })

  if (error) {
    throw new Error('Failed to update user role')
  }
}

export async function createUserProfile(userId: string, fullName: string, role: UserRole = 'user') {
  const supabase = createServerSupabaseClient()

  const { error } = await supabase
    .from('user_profiles')
    .insert({
      user_id: userId,
      full_name: fullName,
      role: role,
      preferences: {}
    })

  if (error) {
    console.error('Failed to create user profile:', error)
    throw new Error('Failed to create user profile')
  }
}