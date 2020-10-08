<template>
  <div class="comment-editor">
    <vue-editor
      v-model="localValue"
      :editorOptions="editorOptions"
    >
      <template #toolbar>
        <div id="toolbar" class="ql-toolbar ql-snow">
          <span class="ql-formats">
            <select class="ql-header">
              <option value="">Normal</option>
              <option value="1">Heading 1</option>
              <option value="2">Heading 2</option>
              <option value="3">Heading 3</option>
            </select>
          </span>

          <span class="ql-formats">
            <button type="button" class="ql-bold" />
            <button type="button" class="ql-italic" />
            <button type="button" class="ql-underline" />
            <button type="button" class="ql-strike" />
          </span>

          <span class="ql-formats">
            <button class="ql-blockquote" />
            <button class="ql-code-block" />
          </span>

          <span class="ql-formats">
            <button class="ql-list" value="ordered" />
            <button class="ql-list" value="bullet" />
          </span>

          <span class="ql-formats">
            <select class="ql-color" />
          </span>

          <span class="ql-formats">
            <button class="ql-clean" />
          </span>
        </div>
      </template>
    </vue-editor>
  </div>
</template>

<script>
import { VueEditor } from 'vue2-editor'

import 'quill-mention'

export default {
  name: 'CommentEditor',
  components: { VueEditor },
  props: {
    value: {
      type: String,
      required: true,
      default: ''
    },
    commentators: {
      type: Array,
      required: true,
      default: () => []
    }
  },
  data() {
    return {
      editorOptions: {
        modules: {
          toolbar: '#toolbar',
          mention: {
            allowedChars: /^[A-Za-z\s]*$/,
            mentionDenotationChars: ['@'],
            source: (searchTerm, renderList) => {
              const items = this.commentators.map(commentator => ({
                id: commentator.id,
                value: commentator.fullname
              }))

              if (searchTerm.length === 0) {
                renderList(items, searchTerm)
                return
              }

              renderList(
                items.filter(item => (
                  item.value.toLowerCase().indexOf(searchTerm.toLowerCase()) > -1
                )),
                searchTerm
              )
            }
          }
        }
      },
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
