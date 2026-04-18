'use client'

import { useState, useRef } from 'react'
import { Bold, Italic, List, ListOrdered, Code, Quote, Heading, Undo, Redo, HelpCircle } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Textarea } from '@/components/ui/textarea'


interface MarkdownEditorProps {
  value: string
  onChange: (value: string) => void
  placeholder?: string
  rows?: number
}

export function MarkdownEditor({
  value,
  onChange,
  placeholder = 'Write markdown content...',
  rows = 10,
}: MarkdownEditorProps) {
  const textareaRef = useRef<HTMLTextAreaElement>(null)
  const [history, setHistory] = useState<string[]>([value])
  const [historyIndex, setHistoryIndex] = useState(0)

  const wrapText = (before: string, after = before) => {
    const textarea = textareaRef.current
    if (!textarea) return

    const start = textarea.selectionStart
    const end = textarea.selectionEnd
    const selected = value.substring(start, end)
    const newValue = value.substring(0, start) + before + selected + after + value.substring(end)

    pushHistory(newValue)
    onChange(newValue)

    setTimeout(() => {
      textarea.focus()
      textarea.setSelectionRange(start + before.length, end + before.length)
    }, 0)
  }

  const insertText = (text: string) => {
    const textarea = textareaRef.current
    if (!textarea) return

    const start = textarea.selectionStart
    const newValue = value.substring(0, start) + text + value.substring(start)

    pushHistory(newValue)
    onChange(newValue)

    setTimeout(() => {
      textarea.focus()
      textarea.setSelectionRange(start + text.length, start + text.length)
    }, 0)
  }

  const pushHistory = (newValue: string) => {
    const newHistory = history.slice(0, historyIndex + 1)
    newHistory.push(newValue)
    if (newHistory.length > 50) newHistory.shift()
    setHistory(newHistory)
    setHistoryIndex(newHistory.length - 1)
  }

  const undo = () => {
    if (historyIndex > 0) {
      const newIndex = historyIndex - 1
      setHistoryIndex(newIndex)
      onChange(history[newIndex])
    }
  }

  const redo = () => {
    if (historyIndex < history.length - 1) {
      const newIndex = historyIndex + 1
      setHistoryIndex(newIndex)
      onChange(history[newIndex])
    }
  }

  const actions = [
    { icon: Bold, title: 'Bold', action: () => wrapText('**') },
    { icon: Italic, title: 'Italic', action: () => wrapText('*') },
    { icon: Heading, title: 'Heading', action: () => insertText('## ') },
    { icon: Quote, title: 'Quote', action: () => insertText('> ') },
    { icon: Code, title: 'Code', action: () => wrapText('`') },
    { icon: List, title: 'Bullet List', action: () => insertText('- ') },
    { icon: ListOrdered, title: 'Numbered List', action: () => insertText('1. ') },
    { icon: Undo, title: 'Undo', action: undo, disabled: historyIndex <= 0 },
    { icon: Redo, title: 'Redo', action: redo, disabled: historyIndex >= history.length - 1 },
  ]

  return (
    <div className="border rounded-lg overflow-hidden">
      <div className="flex gap-1 p-2 border-b bg-muted/30">
          {actions.map((Action, idx) => (
                <Button
                  key={idx}
                  variant="ghost"
                  size="icon"
                  onClick={Action.action}
                  disabled={Action.disabled}
                  className="h-8 w-8"
                  title={Action.title}
                >
                  <Action.icon className="w-4 h-4" />
                </Button>
          ))}
          <div className="ml-auto">
                <a href="https://commonmark.org/help/" target="_blank" rel="noopener noreferrer" title="Markdown syntax help" className="inline-flex items-center justify-center h-8 w-8 rounded-lg hover:bg-muted transition-colors">
                    <HelpCircle className="w-4 h-4" />
                </a>
          </div>
      </div>
      <Textarea
        ref={textareaRef}
        value={value}
        onChange={(e) => {
          onChange(e.target.value)
          if (history[historyIndex] !== e.target.value) {
            pushHistory(e.target.value)
          }
        }}
        placeholder={placeholder}
        rows={rows}
        className="border-0 rounded-none focus-visible:ring-0 focus-visible:ring-offset-0 font-mono text-sm"
      />
    </div>
  )
}
