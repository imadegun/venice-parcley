import Stripe from 'stripe'

if (!process.env.STRIPE_SECRET_KEY) {
  throw new Error('Missing Stripe secret key')
}

export const stripe = new Stripe(process.env.STRIPE_SECRET_KEY, {
  apiVersion: '2026-03-25.dahlia',
  typescript: true,
})

export function formatAmount(amount: number): string {
  return `$${(amount / 100).toFixed(2)}`
}

export function centsToDollars(cents: number): number {
  return cents / 100
}

export function dollarsToCents(dollars: number): number {
  return Math.round(dollars * 100)
}