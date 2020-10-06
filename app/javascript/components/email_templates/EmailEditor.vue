<template>
  <div class="email-editor">
    <vue-editor
      v-model="localValue"
      :editorOptions="editorOptions"
      @text-change="countPlaceholders"
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
            <button class="ql-align" value="" />
            <button class="ql-align" value="center" />
            <button class="ql-align" value="right" />
            <button class="ql-align" value="justify" />
          </span>

          <span class="ql-formats">
            <button class="ql-list" value="ordered" />
            <button class="ql-list" value="bullet" />
          </span>

          <span class="ql-formats">
            <select class="ql-color" />
            <select class="ql-background" />
          </span>

          <span class="ql-formats">
            <button class="ql-clean" />
          </span>

          <span v-if="mode === 'template'" class="ql-formats">
            <select class="ql-placeholder">
              <option
                v-for="placeholder in editorOptions.modules.placeholder.items"
                :key="placeholder.id"
                :value="placeholder.id"
              >
                {{ placeholder.label }}
              </option>
            </select>
          </span>
        </div>
      </template>
    </vue-editor>

    <div class="v-text-field__details mt-2">
      <div :class="['v-messages theme--light', { 'error--text': !validBody }]" role="alert">
        <div class="v-messages__wrapper">
          <div class="v-messages__message">
            Completed Placeholders: {{ placeholderCounts.completed }} of {{ placeholderCounts.total }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { VueEditor, Quill } from 'vue2-editor'
import PlaceholderModule from '@utils/quill/placeholder_module'
import PlaceholdersCounter from '@utils/quill/placeholder_module/placeholders_counter'

import { RecruitDocument } from '@models/recruit_document'

Quill.register('modules/placeholder', PlaceholderModule)

export default {
  name: 'EmailEditor',
  components: { VueEditor },
  props: {
    value: {
      type: String,
      required: true,
      default: ''
    },
    mode: {
      type: String,
      required: false,
      default: ''
    }
  },
  data() {
    return {
      editorOptions: {
        modules: {
          toolbar: '#toolbar',
          placeholder: {
            items: RecruitDocument.placeholders
          }
        }
      },
      placeholderCounts: {
        total: 0,
        completed: 0
      }
    }
  },
  methods: {
    countPlaceholders() {
      const counter = new PlaceholdersCounter()
      this.placeholderCounts = counter.call()

      this.$emit('validate', this.validBody)
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
    },
    validBody() {
      return this.placeholderCounts.total === this.placeholderCounts.completed
    }
  }
}
</script>
