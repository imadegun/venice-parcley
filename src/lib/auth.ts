import { redirect } from 'next/navigation'
import { createServerSupabaseClient } from '@/lib/supabase'
import { createServerAuthClient } from '@/lib/supabase-server'
import type { Database } from '@/types/database'

type UserRole = 'guest' | 'member' | 'user' | 'admin' | 'administrator'

export async function requireAuth() {
  const supabase = await createServerAuthClient()
  const { data: { user }, error } = await supabase.auth.getUser()

  if (error || !user) {
    redirect('/login')
  }

  return user
}

export async function requireRole(requiredRoles: UserRole[] | UserRole = 'guest') {
  const user = await requireAuth()
  const userRole = await getUserRole(user.id)

  // Convert single role to array for consistent handling
  const roleArray = Array.isArray(requiredRoles) ? requiredRoles : [requiredRoles]

  // Check if user has required role
  if (!roleArray.includes(userRole)) {
    // Redirect non-users to homepage, not back to admin
    redirect('/')
  }

  return user
}

export async function getCurrentUser() {
  const supabase = await createServerAuthClient()
  const { data: { user } } = await supabase.auth.getUser()
  return user
}

export async function getUserRole(userId: string): Promise<UserRole> {
  const supabase = createServerSupabaseClient()

  try {
    const { data: profile, error } = await supabase
      .from('profiles')
      .select('role')
      .eq('id', userId)
      .single()

    if (error || !profile || !profile.role) {
      return 'guest'
    }

    return profile.role as UserRole
  } catch {
    return 'guest'
  }
}

export async function getUserProfile(userId: string) {
  const supabase = createServerSupabaseClient()

  const { data: profile, error } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', userId)
    .single()

  if (error) {
    throw new Error('Failed to fetch user profile')
  }

  return profile
}

export async function updateUserRole(userId: string, role: UserRole) {
  const supabase = createServerSupabaseClient()

  const { error } = await supabase
    .from('profiles')
    .update({
      role: role,
      updated_at: new Date().toISOString()
    })
    .eq('id', userId)

  if (error) {
    throw new Error('Failed to update user role')
  }
}

export async function createUserProfile(userId: string, fullName: string, role: UserRole = 'guest') {
  const supabase = createServerSupabaseClient()

  const { error } = await supabase
    .from('profiles')
    .insert({
      id: userId,
      full_name: fullName,
      role: role
    })

  if (error) {
    console.error('Failed to create user profile:', error)
    throw new Error('Failed to create user profile')
  }
}
