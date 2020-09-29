import { Quill } from 'vue2-editor'
import PlaceholderBlot from './placeholder_blot'

Quill.register(PlaceholderBlot)

const Parchment = Quill.import('parchment')

export default class PlaceholderModule {
  constructor(quill, options) {
    this.quill = quill
    this.items = options.items

    quill.getModule('toolbar').addHandler('placeholder', this.onPlaceholderSelect)
    quill.root.addEventListener('click', this.onRootClick)
    // quill.on('text-change', this.onTextChange)
  }

  onPlaceholderSelect = (value) => {
    const placeholder = this.items.find((el) => el.id === value)
    if (!placeholder) throw new Error(`Missing placeholder for ${identifier}`)

    const selection = this.quill.getSelection()

    this.quill.insertEmbed(selection.index, 'placeholder', placeholder, Quill.sources.USER)
    this.quill.setSelection(selection.index + 1, 0)
  }

  onRootClick = (event) => {
    const blot = Parchment.find(event.target.parentNode)

    if (blot instanceof PlaceholderBlot) {
      const index = this.quill.getIndex(blot)
      this.quill.setSelection(index, blot.length(), Quill.sources.USER)
    }
  }
}
