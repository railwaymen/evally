<template>
  <v-layout row wrap class="d-flex align-stretch">
    <v-flex xs12 lg6>
      <div v-if="loading" class="widget__loader">
				<v-progress-circular :size="30" :width="3" color="primary" indeterminate />
			</div>

      <v-card class="pa-3 height-100">
        <v-card-title>
          <span class="headline">{{ $t('views.recruitments.mailer.title', { to: recruitDocument.fullname }) }}</span>
        </v-card-title>

        <v-form ref="form" @submit.prevent="sendEmail">
          <v-card-text>
            <v-layout row wrap>
              <v-flex class="px-2" xs12 lg6>
                <v-select
                  :items="emailTemplates.models"
                  @change="selectTemplate"
                  :label="$t('shared.general.fields.emailTemplate')"
                  prepend-inner-icon="mdi-email-edit-outline"
                  item-value="id"
                  item-text="name"
                  small
                />
              </v-flex>

              <v-flex class="px-2" xs12>
                <v-text-field
                  v-model="localEmail.from"
                  :rules="[vRequired]"
                  :label="$t('shared.general.fields.from')"
                  prepend-inner-icon="mdi-logout-variant"
                  small
                />
              </v-flex>

              <v-flex class="px-2" xs12>
                <v-text-field
                  v-model="localEmail.to"
                  :rules="[vRequired]"
                  :label="$t('shared.general.fields.to')"
                  prepend-inner-icon="mdi-login-variant"
                  small
                />
              </v-flex>

              <v-flex class="px-2" xs12>
                <v-text-field
                  v-model="localEmail.subject"
                  :rules="[vRequired]"
                  :label="$t('shared.general.fields.subject')"
                  prepend-inner-icon="mdi-chevron-right"
                  small
                />
              </v-flex>

              <v-flex class="px-2 mt-5" xs12>
                <email-editor v-model="localEmail.body" @validate="validBody = $event" />
              </v-flex>
            </v-layout>
          </v-card-text>

          <v-card-actions>
            <v-spacer />

            <v-btn
              @click="reset"
              color="grey darken-1"
              text
            >
              {{ $t('shared.buttons.reset') }}
            </v-btn>

            <v-btn
              type="submit"
              color="green darken-1"
              text
            >
              {{ $t('shared.buttons.send') }}
            </v-btn>
          </v-card-actions>
        </v-form>
      </v-card>
    </v-flex>

    <v-flex xs12 lg6>
      <div v-if="loading" class="widget__loader">
				<v-progress-circular :size="30" :width="3" color="primary" indeterminate />
			</div>

      <v-card class="pa-3 height-100">
        <v-card-text>
          <div class="email__preview" v-html="localEmail.body" />
          <div class="email__signature mt-3" v-html="localEmail.signature" />
        </v-card-text>
      </v-card>
    </v-flex>
  </v-layout>
</template>

<script>
import { mapState } from 'vuex'

import EmailEditor from '@components/email_templates/EmailEditor'

import { Email } from '@models/email'

export default {
  name: 'RecruitmentMailer',
  components: {
    EmailEditor
  },
  data() {
    return {
      localEmail: new Email(),
      validBody: true
    }
  },
  methods: {
    reset() {
      this.$refs.form.reset()
      this.localEmail = new Email()
    },
    sendEmail() {
      if (!this.validBody) {
        this.flash({ error: 'Your email has still some uncompleted placeholders' })

        return
      }

      if (this.$refs.form.validate()) {
        console.log(this.localEmail)
      }
    },
    selectTemplate(id) {
      const template = this.emailTemplates.findById(id)

      const doc = new DOMParser().parseFromString(template.body, 'text/html')

      Array.from(doc.querySelectorAll('.ql-placeholder-tag')).map(node => {
        const value = this.recruitDocument[node.dataset.id]

        if (value) {
          node.innerText = value
          node.setAttribute('data-autocompleted', true)
        }
      })

      this.localEmail = new Email({
        from: this.user.email,
        to: this.recruitDocument.email,
        subject: template.subject,
        body: doc.body.innerHTML,
        signature: this.user.signature,
        public_recruit_id: this.recruitDocument.public_recruit_id,
        recruit_document_id: this.recruitDocument.id
      })
    }
  },
  computed: {
    ...mapState('EmailsModule', [
      'emailTemplates',
      'recruitDocument',
      'user',
      'loading'
    ])
  },
  created() {
    this.$store.dispatch('EmailsModule/fetchData', this.$route.params.id)
  }
}
</script>
