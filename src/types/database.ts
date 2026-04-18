export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      apartments: {
        Row: {
          id: string
          created_at: string
          updated_at: string
          name: string
          description: string
          short_description: string | null
          category: 'artistic_studio' | 'design_loft' | 'creative_suite' | 'artist_residence'
          max_guests: number
          bedrooms: number
          bathrooms: number
          size_sqm: number
          base_price_cents: number
          image_url: string | null
          gallery_images: string[]
          amenities: string[]
          location_details: Json | null
          is_active: boolean
        }
        Insert: {
          id?: string
          created_at?: string
          updated_at?: string
          name: string
          description: string
          short_description?: string | null
          category: 'artistic_studio' | 'design_loft' | 'creative_suite' | 'artist_residence'
          max_guests: number
          bedrooms: number
          bathrooms: number
          size_sqm: number
          base_price_cents: number
          image_url?: string | null
          gallery_images?: string[]
          amenities?: string[]
          location_details?: Json | null
          is_active?: boolean
        }
        Update: {
          id?: string
          created_at?: string
          updated_at?: string
          name?: string
          description?: string
          short_description?: string | null
          category?: 'artistic_studio' | 'design_loft' | 'creative_suite' | 'artist_residence'
          max_guests?: number
          bedrooms?: number
          bathrooms?: number
          size_sqm?: number
          base_price_cents?: number
          image_url?: string | null
          gallery_images?: string[]
          amenities?: string[]
          location_details?: Json | null
          is_active?: boolean
        }
      }
      transportation_services: {
        Row: {
          id: string
          created_at: string
          updated_at: string
          slug: string
          name: string
          category: 'cars' | 'taxis' | 'chauffeurs' | 'airport_transfers'
          description: string
          capacity: number
          price_cents: number
          image_url: string | null
          features: string[]
          is_active: boolean
        }
        Insert: {
          id?: string
          created_at?: string
          updated_at?: string
          slug: string
          name: string
          category: 'cars' | 'taxis' | 'chauffeurs' | 'airport_transfers'
          description: string
          capacity: number
          price_cents: number
          image_url?: string | null
          features?: string[]
          is_active?: boolean
        }
        Update: {
          id?: string
          created_at?: string
          updated_at?: string
          slug?: string
          name?: string
          category?: 'cars' | 'taxis' | 'chauffeurs' | 'airport_transfers'
          description?: string
          capacity?: number
          price_cents?: number
          image_url?: string | null
          features?: string[]
          is_active?: boolean
        }
      }
      bookings: {
        Row: {
          id: string
          created_at: string
          updated_at: string
          user_id: string
          apartment_id: string | null
          transportation_id: string | null
          check_in_date: string | null
          check_out_date: string | null
          service_date: string | null
          service_time: string | null
          total_guests: number | null
          total_cents: number
          status: 'pending' | 'confirmed' | 'cancelled' | 'completed'
          special_requests: string | null
          contact_info: Json
        }
        Insert: {
          id?: string
          created_at?: string
          updated_at?: string
          user_id: string
          apartment_id?: string | null
          transportation_id?: string | null
          check_in_date?: string | null
          check_out_date?: string | null
          service_date?: string | null
          service_time?: string | null
          total_guests?: number | null
          total_cents: number
          status?: 'pending' | 'confirmed' | 'cancelled' | 'completed'
          special_requests?: string | null
          contact_info: Json
        }
        Update: {
          id?: string
          created_at?: string
          updated_at?: string
          user_id?: string
          apartment_id?: string | null
          transportation_id?: string | null
          check_in_date?: string | null
          check_out_date?: string | null
          service_date?: string | null
          service_time?: string | null
          total_guests?: number | null
          total_cents?: number
          status?: 'pending' | 'confirmed' | 'cancelled' | 'completed'
          special_requests?: string | null
          contact_info?: Json
        }
      }
      user_profiles: {
        Row: {
          id: string
          created_at: string
          updated_at: string
          user_id: string
          full_name: string
          phone?: string
          date_of_birth?: string
          nationality?: string
          passport_number?: string
          emergency_contact?: Json
          preferences: Json
          role: 'user' | 'admin' | 'administrator'
        }
        Insert: {
          id?: string
          created_at?: string
          updated_at?: string
          user_id: string
          full_name: string
          phone?: string
          date_of_birth?: string
          nationality?: string
          passport_number?: string
          emergency_contact?: Json
          preferences?: Json
          role?: 'user' | 'admin' | 'administrator'
        }
        Update: {
          id?: string
          created_at?: string
          updated_at?: string
          user_id?: string
          full_name?: string
          phone?: string
          date_of_birth?: string
          nationality?: string
          passport_number?: string
          emergency_contact?: Json
          preferences?: Json
          role?: 'user' | 'admin' | 'administrator'
        }
      }
      content_sections: {
        Row: {
          id: string
          key: 'homepage' | 'about' | 'contact'
          payload: Json
          status: 'draft' | 'published'
          version: number
          created_by?: string
          updated_by?: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          key: 'homepage' | 'about' | 'contact'
          payload: Json
          status?: 'draft' | 'published'
          version?: number
          created_by?: string
          updated_by?: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          key?: 'homepage' | 'about' | 'contact'
          payload?: Json
          status?: 'draft' | 'published'
          version?: number
          created_by?: string
          updated_by?: string
          created_at?: string
          updated_at?: string
        }
      }
      content_revisions: {
        Row: {
          id: string
          section_id: string
          key: 'homepage' | 'about' | 'contact'
          payload: Json
          version: number
          published_by?: string
          published_at: string
        }
        Insert: {
          id?: string
          section_id: string
          key: 'homepage' | 'about' | 'contact'
          payload: Json
          version: number
          published_by?: string
          published_at?: string
        }
        Update: {
          id?: string
          section_id?: string
          key?: 'homepage' | 'about' | 'contact'
          payload?: Json
          version?: number
          published_by?: string
          published_at?: string
        }
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}
