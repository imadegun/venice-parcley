import { PrismaClient } from '@prisma/client'

const prismaClientSingleton = () => {
  return new PrismaClient({
    log: process.env.NODE_ENV === 'development' ? ['query', 'error', 'warn'] : ['error'],
    // Neon database connection pool configuration
    datasource: {
      db: {
        url: process.env.DATABASE_URL,
      }
    }
  }).$extends({
    query: {
      $allOperations: {
        async query({ model, operation, args, query }) {
          // Add connection timeout handling
          try {
            return await query(args)
          } catch (error: any) {
            if (error.code === 'P2024') {
              // Retry once on pool timeout
              return await query(args)
            }
            throw error
          }
        }
      }
    }
  })
}

declare global {
  var prisma: undefined | ReturnType<typeof prismaClientSingleton>
}

export const db = globalThis.prisma ?? prismaClientSingleton()

if (process.env.NODE_ENV !== 'production') globalThis.prisma = db

// Helper utilities
export * from '@prisma/client'
export default db

// Raw SQL query helper for backward compatibility
export async function query(sql: string) {
  const rows = await (db as any).$queryRawUnsafe(sql)
  return { rows }
}
