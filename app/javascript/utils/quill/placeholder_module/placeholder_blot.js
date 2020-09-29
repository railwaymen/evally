import { Quill } from 'vue2-editor'

const Embed = Quill.import('blots/embed')

export default class PlaceholderBlot extends Embed {
  static create = value => {
    const node = super.create()

    node.setAttribute('data-id', value.id)
    node.setAttribute('data-label', value.label)

    node.appendChild(
      document.createTextNode(`{${value.label}}`)
    )

    return node
  }

  static value = node => node.dataset

  length = () => 1
}

PlaceholderBlot.blotName = 'placeholder'
PlaceholderBlot.tagName = 'span'
PlaceholderBlot.className = 'ql-placeholder-tag'
