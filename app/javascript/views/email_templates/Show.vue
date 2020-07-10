<template>
  <div class="box email">
    <v-form ref="form">
      <v-layout row wrap>
        <v-flex xs12>
          <div class="email__name">
            <v-text-field
              v-model="emailTemplate.name"
              label="Template Name"
              :disabled="!emailTemplate.editable"
              :rules="[vRequired]"
            />
          </div>
        </v-flex>

        <v-flex xs12>
          <div class="email__to">
            <v-text-field
              value="Recipient Name <recipient@example.com>"
              label="To"
              disabled
            />
          </div>

          <div class="email__subject">
            <v-text-field
              v-model="emailTemplate.subject"
              label="Subject"
              :disabled="!emailTemplate.editable"
              :rules="[vRequired]"
            />
          </div>

          <div v-if="emailTemplate.editable" class="email__body">
            <label :class="{ 'email__field-label': true, 'email__field-label--disabled': !emailTemplate.editable }">
              Message Editor
            </label>

            <vue-editor
              v-model="emailTemplate.body"
            />
          </div>

          <div v-if="emailTemplate.body.length > 0" class="email__preview">
            <label class="email__field-label">Preview</label>

            <div v-html="emailTemplate.body" />
          </div>
        </v-flex>
      </v-layout>
    </v-form>
  </div>
</template>

<script>
import { mapState } from 'vuex'

import { VueEditor } from 'vue2-editor';

// Quill Awesome
// https://github.com/Fandom-OSS/quill-blot-formatter - resize and realign images

export default {
  name: 'EmailTemplateShow',
  components: {
    VueEditor
  },
  data() {
    return {
      toolbar: [
        [
          { 'header': [false, 1, 2, 3, 4, 5, 6] }
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
    ...mapState('EmailTemplatesModule', [
      'emailTemplate'
    ]),
  },
  watch: {
    $route: {
      immediate: true,
      handler(to) {
        this.$store.dispatch('EmailTemplatesModule/fetchTemplate', to.params.id)
      }
    }
  }
}
</script>
