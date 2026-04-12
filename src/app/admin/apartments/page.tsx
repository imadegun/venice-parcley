import { requireRole } from '@/lib/auth'
import { createServerSupabaseClient } from '@/lib/supabase'
import { createApartment, deleteApartment, updateApartment } from './actions'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { Textarea } from '@/components/ui/textarea'
import { Button } from '@/components/ui/button'
import { Label } from '@/components/ui/label'

const apartmentTypes = [
  'artistic_studio',
  'design_loft',
  'creative_suite',
  'artist_residence',
] as const

export default async function AdminApartmentsPage() {
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()
  const { data: apartments, error } = await supabase
    .from('apartments')
    .select('*')
    .order('created_at', { ascending: false })

  if (error) {
    throw new Error(error.message)
  }

  return (
    <div className="space-y-8">
      <div>
        <h1 className="text-3xl font-semibold text-gray-900">Apartments Management</h1>
        <p className="text-gray-600">Create, update, and delete apartment inventory.</p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Create Apartment</CardTitle>
        </CardHeader>
        <CardContent>
          <form action={createApartment} className="grid gap-4 md:grid-cols-2">
            <div className="space-y-2">
              <Label htmlFor="name">Name</Label>
              <Input id="name" name="name" required />
            </div>
            <div className="space-y-2">
              <Label htmlFor="type">Type</Label>
              <select id="type" name="type" className="h-10 w-full rounded-md border px-3" required>
                {apartmentTypes.map((type) => (
                  <option key={type} value={type}>
                    {type}
                  </option>
                ))}
              </select>
            </div>
            <div className="space-y-2 md:col-span-2">
              <Label htmlFor="description">Description</Label>
              <Textarea id="description" name="description" required />
            </div>
            <div className="space-y-2">
              <Label htmlFor="address">Address</Label>
              <Input id="address" name="address" required />
            </div>
            <div className="space-y-2">
              <Label htmlFor="city">City</Label>
              <Input id="city" name="city" required />
            </div>
            <div className="space-y-2">
              <Label htmlFor="country">Country</Label>
              <Input id="country" name="country" required />
            </div>
            <div className="space-y-2">
              <Label htmlFor="price_per_night">Price / Night</Label>
              <Input id="price_per_night" name="price_per_night" type="number" min="0" required />
            </div>
            <div className="space-y-2">
              <Label htmlFor="max_guests">Max Guests</Label>
              <Input id="max_guests" name="max_guests" type="number" min="1" required />
            </div>
            <div className="space-y-2">
              <Label htmlFor="bedrooms">Bedrooms</Label>
              <Input id="bedrooms" name="bedrooms" type="number" min="0" required />
            </div>
            <div className="space-y-2">
              <Label htmlFor="bathrooms">Bathrooms</Label>
              <Input id="bathrooms" name="bathrooms" type="number" min="0" step="0.5" required />
            </div>
            <div className="space-y-2">
              <Label htmlFor="size_sqm">Size (sqm)</Label>
              <Input id="size_sqm" name="size_sqm" type="number" min="1" required />
            </div>
            <div className="space-y-2 md:col-span-2">
              <Label htmlFor="amenities">Amenities (comma separated)</Label>
              <Input id="amenities" name="amenities" />
            </div>
            <div className="space-y-2 md:col-span-2">
              <Label htmlFor="images">Images (comma separated URLs)</Label>
              <Input id="images" name="images" />
            </div>
            <div className="md:col-span-2">
              <Button type="submit">Create Apartment</Button>
            </div>
          </form>
        </CardContent>
      </Card>

      <div className="space-y-4">
        {apartments?.map((apt) => (
          <Card key={apt.id}>
            <CardHeader>
              <CardTitle>{apt.name}</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <form action={updateApartment} className="grid gap-4 md:grid-cols-2">
                <input type="hidden" name="id" value={apt.id} />
                <div className="space-y-2">
                  <Label>Name</Label>
                  <Input name="name" defaultValue={apt.name} required />
                </div>
                <div className="space-y-2">
                  <Label>Type</Label>
                  <select
                    name="type"
                    defaultValue={apt.type}
                    className="h-10 w-full rounded-md border px-3"
                    required
                  >
                    {apartmentTypes.map((type) => (
                      <option key={type} value={type}>
                        {type}
                      </option>
                    ))}
                  </select>
                </div>
                <div className="space-y-2 md:col-span-2">
                  <Label>Description</Label>
                  <Textarea name="description" defaultValue={apt.description} required />
                </div>
                <div className="space-y-2">
                  <Label>Address</Label>
                  <Input name="address" defaultValue={apt.address} required />
                </div>
                <div className="space-y-2">
                  <Label>City</Label>
                  <Input name="city" defaultValue={apt.city} required />
                </div>
                <div className="space-y-2">
                  <Label>Country</Label>
                  <Input name="country" defaultValue={apt.country} required />
                </div>
                <div className="space-y-2">
                  <Label>Price / Night</Label>
                  <Input name="price_per_night" type="number" min="0" defaultValue={apt.price_per_night} required />
                </div>
                <div className="space-y-2">
                  <Label>Max Guests</Label>
                  <Input name="max_guests" type="number" min="1" defaultValue={apt.max_guests} required />
                </div>
                <div className="space-y-2">
                  <Label>Bedrooms</Label>
                  <Input name="bedrooms" type="number" min="0" defaultValue={apt.bedrooms} required />
                </div>
                <div className="space-y-2">
                  <Label>Bathrooms</Label>
                  <Input name="bathrooms" type="number" min="0" step="0.5" defaultValue={apt.bathrooms} required />
                </div>
                <div className="space-y-2">
                  <Label>Size (sqm)</Label>
                  <Input name="size_sqm" type="number" min="1" defaultValue={apt.size_sqm} required />
                </div>
                <div className="space-y-2 md:col-span-2">
                  <Label>Amenities (comma separated)</Label>
                  <Input name="amenities" defaultValue={apt.amenities.join(', ')} />
                </div>
                <div className="space-y-2 md:col-span-2">
                  <Label>Images (comma separated URLs)</Label>
                  <Input name="images" defaultValue={apt.images.join(', ')} />
                </div>
                <div className="md:col-span-2 flex gap-2">
                  <Button type="submit">Update</Button>
                </div>
              </form>

              <form action={deleteApartment}>
                <input type="hidden" name="id" value={apt.id} />
                <Button type="submit" variant="destructive">Delete</Button>
              </form>
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  )
}
