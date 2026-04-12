import { createServerAuthClient } from '@/lib/supabase-server'
import { getUserRole } from '@/lib/auth'

export default async function DebugAuthPage() {
  const supabase = await createServerAuthClient()
  const { data: { user } } = await supabase.auth.getUser()
  
  let userRole = null
  let profileData = null
  
  if (user) {
    userRole = await getUserRole(user.id)
    
    const { data: profile } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', user.id)
      .single()
    
    profileData = profile
  }

  return (
    <div className="p-8 max-w-2xl mx-auto">
      <h1 className="text-2xl font-bold mb-6">Auth Debug Page</h1>
      
      <div className="space-y-6">
        <div className="border p-4 rounded-lg">
          <h2 className="font-semibold mb-2">User Session</h2>
          <pre className="text-sm bg-gray-100 p-2 rounded overflow-auto">
            {JSON.stringify(user, null, 2)}
          </pre>
        </div>
        
        <div className="border p-4 rounded-lg">
          <h2 className="font-semibold mb-2">User Role</h2>
          <p>Calculated role: <strong>{userRole}</strong></p>
        </div>
        
        <div className="border p-4 rounded-lg">
          <h2 className="font-semibold mb-2">Profile Data</h2>
          <pre className="text-sm bg-gray-100 p-2 rounded overflow-auto">
            {JSON.stringify(profileData, null, 2)}
          </pre>
        </div>
        
        <div className="border p-4 rounded-lg">
          <h2 className="font-semibold mb-2">Cookies</h2>
          <pre className="text-sm bg-gray-100 p-2 rounded overflow-auto">
            {JSON.stringify(await supabase.auth.getSession())}
          </pre>
        </div>
      </div>
    </div>
  )
}
