<template>
  <div class="comment-editor">
    <vue-editor
      v-model="localValue"
      :editor-toolbar="toolbar"
    />
  </div>
</template>

<script>
import { VueEditor } from 'vue2-editor'

export default {
  name: 'CommentEditor',
  components: { VueEditor },
  props: {
    value: {
      type: String,
      required: true,
      default: ''
    }
  },
  data() {
    return {
      toolbar: [
        [
          { 'header': [false, 1, 2, 3] }
        ],
        [
          'bold',
          'italic',
          'underline',
          'strike'
        ],
        [
          'blockquote',
          'code-block'
        ],
        [
          { 'list': 'ordered'},
          { 'list': 'bullet' }
        ],
        [
          { 'color': [] },
        ]
      ]
    }
  },
  computed: {
    localValue: {
      get() {
        return this.value
      },
      set(val) {
        this.$emit('input', val)
      }
    }
  }
}
</script>
