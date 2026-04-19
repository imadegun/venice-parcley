'use client'

import { useState, useEffect } from 'react'
import { loadStripe } from '@stripe/stripe-js'
import { Elements, PaymentElement, useStripe, useElements } from '@stripe/react-stripe-js'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { AlertCircle, CreditCard, Lock } from 'lucide-react'

const stripePromise = loadStripe(process.env.NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY!)

interface StripePaymentFormProps {
  clientSecret: string
  onPaymentSuccess: (paymentIntent: any) => void
  onPaymentError: (error: string) => void
  amount: number
  currency?: string
}

function PaymentForm({ onPaymentSuccess, onPaymentError, amount, currency = 'eur' }: Omit<StripePaymentFormProps, 'clientSecret'>) {
  const stripe = useStripe()
  const elements = useElements()
  const [isProcessing, setIsProcessing] = useState(false)
  const [message, setMessage] = useState<string>('')

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault()

    if (!stripe || !elements) {
      return
    }

    setIsProcessing(true)
    setMessage('')

    try {
      const { error, paymentIntent } = await stripe.confirmPayment({
        elements,
        confirmParams: {
          return_url: `${window.location.origin}/booking/confirmation`,
        },
        redirect: 'if_required',
      })

      if (error) {
        setMessage(error.message || 'Payment failed')
        onPaymentError(error.message || 'Payment failed')
      } else if (paymentIntent && paymentIntent.status === 'succeeded') {
        setMessage('Payment succeeded!')
        onPaymentSuccess(paymentIntent)
      }
    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : 'Payment failed'
      setMessage(errorMessage)
      onPaymentError(errorMessage)
    } finally {
      setIsProcessing(false)
    }
  }

  const paymentElementOptions = {
    layout: 'tabs' as const,
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-6">
      <div className="space-y-4">
        <PaymentElement options={paymentElementOptions} className="min-h-[200px]" />

        <div className="flex items-center gap-2 text-sm text-gray-600">
          <Lock className="h-4 w-4" />
          <span>Your payment information is secure and encrypted</span>
        </div>
      </div>

      {message && (
        <div className={`p-3 rounded-md text-sm ${message.includes('succeeded') ? 'bg-green-50 text-green-700 border border-green-200' : 'bg-red-50 text-red-700 border border-red-200'}`}>
          {message}
        </div>
      )}

      <Button
        type="submit"
        className="w-full"
        disabled={!stripe || isProcessing}
        size="lg"
      >
        {isProcessing ? (
          <>
            <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white mr-2"></div>
            Processing payment...
          </>
        ) : (
          <>
            <CreditCard className="h-4 w-4 mr-2" />
            Pay €{(amount / 100).toFixed(2)}
          </>
        )}
      </Button>

      <div className="text-center text-xs text-gray-500 space-y-1">
        <p>Powered by Stripe</p>
        <p>Your card details are never stored on our servers</p>
      </div>
    </form>
  )
}

export function StripePaymentForm({ clientSecret, onPaymentSuccess, onPaymentError, amount, currency = 'eur' }: StripePaymentFormProps) {
  const options = {
    clientSecret,
    appearance: {
      theme: 'stripe' as const,
      variables: {
        colorPrimary: '#3b82f6',
        colorBackground: '#ffffff',
        colorText: '#30313d',
        colorDanger: '#df1b41',
        fontFamily: 'system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif',
        spacingUnit: '4px',
        borderRadius: '6px',
      },
      rules: {
        '.Input': {
          boxShadow: '0 1px 2px 0 rgba(0, 0, 0, 0.05)',
        },
        '.Input:focus': {
          borderColor: '#3b82f6',
          boxShadow: '0 0 0 1px #3b82f6',
        },
      },
    },
  }

  return (
    <Elements stripe={stripePromise} options={options}>
      <PaymentForm
        onPaymentSuccess={onPaymentSuccess}
        onPaymentError={onPaymentError}
        amount={amount}
        currency={currency}
      />
    </Elements>
  )
}
