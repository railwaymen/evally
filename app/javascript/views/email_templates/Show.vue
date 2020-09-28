<template>
  <div class="box email">
    <v-form ref="form">
      <v-layout row wrap>
        <v-flex xs12>
          <div class="email__name">
            <v-text-field
              v-model="templateName"
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
              v-model="templateSubject"
              label="Subject"
              :disabled="!emailTemplate.editable"
              :rules="[vRequired]"
            />
          </div>

          <div v-if="emailTemplate.editable" class="email__body">
            <label :class="{ 'email__field-label': true, 'email__field-label--disabled': !emailTemplate.editable }">
              Message Editor
            </label>

            <body-editor v-model="templateBody" />
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

import BodyEditor from '@components/email_templates/BodyEditor'

export default {
  name: 'EmailTemplateShow',
  components: {
    BodyEditor
  },
  computed: {
    ...mapState('EmailTemplatesModule', [
      'emailTemplate'
    ]),
    templateName: {
      get() {
        return this.emailTemplate.name
      },
      set(name) {
        this.$store.commit(
          'EmailTemplatesModule/REFRESH_TEMPLATE', {
            ...this.emailTemplate,
            name
          }
        )
      }
    },
    templateSubject: {
      get() {
        return this.emailTemplate.subject
      },
      set(subject) {
        this.$store.commit(
          'EmailTemplatesModule/REFRESH_TEMPLATE', {
            ...this.emailTemplate,
            subject
          }
        )
      }
    },
    templateBody: {
      get() {
        return this.emailTemplate.body
      },
      set(body) {
        this.$store.commit(
          'EmailTemplatesModule/REFRESH_TEMPLATE', {
            ...this.emailTemplate,
            body
          }
        )
      }
    }
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
