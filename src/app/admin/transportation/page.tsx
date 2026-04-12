import { requireRole } from '@/lib/auth'
import { createServerSupabaseClient } from '@/lib/supabase'
import {
  createTransportationService,
  deleteTransportationService,
  updateTransportationService,
} from './actions'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { Textarea } from '@/components/ui/textarea'
import { Label } from '@/components/ui/label'
import { Button } from '@/components/ui/button'

const serviceTypes = ['car', 'taxi', 'chauffeur', 'airport_transfer'] as const

export default async function AdminTransportationPage() {
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()

  const { data: services, error } = await supabase
    .from('transportation_services')
    .select('*')
    .order('created_at', { ascending: false })

  if (error) {
    throw new Error(error.message)
  }

  return (
    <div className="space-y-8">
      <div>
        <h1 className="text-3xl font-semibold text-gray-900">Transportation Management</h1>
        <p className="text-gray-600">Manage transportation services with complete CRUD operations.</p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Create Service</CardTitle>
        </CardHeader>
        <CardContent>
          <form action={createTransportationService} className="grid gap-4 md:grid-cols-2">
            <div className="space-y-2">
              <Label htmlFor="name">Name</Label>
              <Input id="name" name="name" required />
            </div>
            <div className="space-y-2">
              <Label htmlFor="type">Type</Label>
              <select id="type" name="type" className="h-10 w-full rounded-md border px-3" required>
                {serviceTypes.map((type) => (
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
              <Label htmlFor="base_price">Base Price</Label>
              <Input id="base_price" name="base_price" type="number" min="0" step="0.01" required />
            </div>
            <div className="space-y-2">
              <Label htmlFor="price_per_km">Price per KM</Label>
              <Input id="price_per_km" name="price_per_km" type="number" min="0" step="0.01" required />
            </div>
            <div className="space-y-2">
              <Label htmlFor="price_per_hour">Price per Hour</Label>
              <Input id="price_per_hour" name="price_per_hour" type="number" min="0" step="0.01" required />
            </div>
            <div className="space-y-2">
              <Label htmlFor="max_passengers">Max Passengers</Label>
              <Input id="max_passengers" name="max_passengers" type="number" min="1" required />
            </div>
            <div className="space-y-2 md:col-span-2">
              <Label htmlFor="provider_id">Provider User ID (UUID)</Label>
              <Input id="provider_id" name="provider_id" required />
            </div>
            <div className="md:col-span-2">
              <Button type="submit">Create Service</Button>
            </div>
          </form>
        </CardContent>
      </Card>

      <div className="space-y-4">
        {services?.map((service) => (
          <Card key={service.id}>
            <CardHeader>
              <CardTitle>{service.name}</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <form action={updateTransportationService} className="grid gap-4 md:grid-cols-2">
                <input type="hidden" name="id" value={service.id} />
                <div className="space-y-2">
                  <Label>Name</Label>
                  <Input name="name" defaultValue={service.name} required />
                </div>
                <div className="space-y-2">
                  <Label>Type</Label>
                  <select name="type" defaultValue={service.type} className="h-10 w-full rounded-md border px-3" required>
                    {serviceTypes.map((type) => (
                      <option key={type} value={type}>
                        {type}
                      </option>
                    ))}
                  </select>
                </div>
                <div className="space-y-2 md:col-span-2">
                  <Label>Description</Label>
                  <Textarea name="description" defaultValue={service.description} required />
                </div>
                <div className="space-y-2">
                  <Label>Base Price</Label>
                  <Input name="base_price" type="number" min="0" step="0.01" defaultValue={service.base_price} required />
                </div>
                <div className="space-y-2">
                  <Label>Price per KM</Label>
                  <Input name="price_per_km" type="number" min="0" step="0.01" defaultValue={service.price_per_km} required />
                </div>
                <div className="space-y-2">
                  <Label>Price per Hour</Label>
                  <Input name="price_per_hour" type="number" min="0" step="0.01" defaultValue={service.price_per_hour} required />
                </div>
                <div className="space-y-2">
                  <Label>Max Passengers</Label>
                  <Input name="max_passengers" type="number" min="1" defaultValue={service.max_passengers} required />
                </div>
                <div className="space-y-2 md:col-span-2">
                  <Label>Provider User ID</Label>
                  <Input name="provider_id" defaultValue={service.provider_id} required />
                </div>
                <div className="md:col-span-2">
                  <Button type="submit">Update</Button>
                </div>
              </form>

              <form action={deleteTransportationService}>
                <input type="hidden" name="id" value={service.id} />
                <Button type="submit" variant="destructive">Delete</Button>
              </form>
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  )
}
