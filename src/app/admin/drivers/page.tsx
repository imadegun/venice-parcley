import { requireRole } from '@/lib/auth'
import { createServerSupabaseClient } from '@/lib/supabase'
import { createDriver, deleteDriver, updateDriver } from './actions'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { Textarea } from '@/components/ui/textarea'
import { Label } from '@/components/ui/label'
import { Button } from '@/components/ui/button'

export default async function AdminDriversPage() {
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()

  const { data: drivers, error } = await supabase
    .from('drivers')
    .select('*')
    .order('created_at', { ascending: false })

  if (error) {
    throw new Error(error.message)
  }

  return (
    <div className="space-y-8">
      <div>
        <h1 className="text-3xl font-semibold text-gray-900">Drivers Management</h1>
        <p className="text-gray-600">Manage driver records with full CRUD operations.</p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Create Driver</CardTitle>
        </CardHeader>
        <CardContent>
          <form action={createDriver} className="grid gap-4 md:grid-cols-2">
            <div className="space-y-2">
              <Label htmlFor="name">Name</Label>
              <Input id="name" name="name" required />
            </div>
            <div className="space-y-2">
              <Label htmlFor="license_number">License Number</Label>
              <Input id="license_number" name="license_number" />
            </div>
            <div className="space-y-2 md:col-span-2">
              <Label htmlFor="bio">Biography</Label>
              <Textarea id="bio" name="bio" />
            </div>
            <div className="space-y-2 md:col-span-2">
              <Label htmlFor="image_url">Image URL</Label>
              <Input id="image_url" name="image_url" />
            </div>
            <div className="space-y-2 md:col-span-2">
              <Label htmlFor="specialties">Specialties (comma separated)</Label>
              <Input id="specialties" name="specialties" />
            </div>
            <div className="md:col-span-2">
              <Button type="submit">Create Driver</Button>
            </div>
          </form>
        </CardContent>
      </Card>

      <div className="space-y-4">
        {drivers?.map((driver) => (
          <Card key={driver.id}>
            <CardHeader>
              <CardTitle>{driver.name}</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <form action={updateDriver} className="grid gap-4 md:grid-cols-2">
                <input type="hidden" name="id" value={driver.id} />
                <div className="space-y-2">
                  <Label>Name</Label>
                  <Input name="name" defaultValue={driver.name} required />
                </div>
                <div className="space-y-2">
                  <Label>License Number</Label>
                  <Input name="license_number" defaultValue={driver.license_number || ''} />
                </div>
                <div className="space-y-2 md:col-span-2">
                  <Label>Biography</Label>
                  <Textarea name="bio" defaultValue={driver.bio || ''} />
                </div>
                <div className="space-y-2 md:col-span-2">
                  <Label>Image URL</Label>
                  <Input name="image_url" defaultValue={driver.image_url || ''} />
                </div>
                <div className="space-y-2 md:col-span-2">
                  <Label>Specialties (comma separated)</Label>
                  <Input name="specialties" defaultValue={driver.specialties.join(', ')} />
                </div>
                <div className="md:col-span-2">
                  <Button type="submit">Update</Button>
                </div>
              </form>

              <form action={deleteDriver}>
                <input type="hidden" name="id" value={driver.id} />
                <Button type="submit" variant="destructive">Delete</Button>
              </form>
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  )
}
