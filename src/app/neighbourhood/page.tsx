import { Container } from '@/components/layout/container'

export default function NeighbourhoodPage() {
  return (
    <Container className="py-16">
      <div className="max-w-4xl mx-auto">
        <h1 className="text-4xl font-serif font-semibold text-gray-900 mb-8">
          Neighbourhood
        </h1>
        <div className="prose prose-lg">
          <p className="text-gray-600 mb-6">
            Discover the vibrant neighbourhood surrounding Venice Parcley.
          </p>
          <p className="text-gray-600">
            Content coming soon...
          </p>
        </div>
      </div>
    </Container>
  )
}