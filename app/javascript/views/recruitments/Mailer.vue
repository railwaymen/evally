<template>
  <v-layout row wrap class="d-flex align-stretch">
    <v-flex xs12 lg6>
      <div v-if="loading" class="widget__loader">
				<v-progress-circular :size="30" :width="3" color="primary" indeterminate />
			</div>

      <v-card class="pa-3 height-100">
        <v-card-title>
          <span class="headline">{{ $t('views.recruitments.mailer.title') }}</span>
        </v-card-title>

        <v-form ref="form">
          <v-card-text>
            <v-layout row wrap>
              <v-flex class="px-2" xs12 lg6>
                <v-select
                  :items="[]"
                  :label="$t('shared.general.fields.emailTemplate')"
                  prepend-inner-icon="mdi-email-edit-outline"
                  item-value="id"
                  item-text="name"
                  small
                />
              </v-flex>

              <v-flex class="px-2" xs12>
                <v-text-field
                  :label="$t('shared.general.fields.from')"
                  prepend-inner-icon="mdi-logout-variant"
                  small
                />
              </v-flex>

              <v-flex class="px-2" xs12>
                <v-text-field
                  :label="$t('shared.general.fields.to')"
                  prepend-inner-icon="mdi-login-variant"
                  small
                />
              </v-flex>

              <v-flex class="px-2" xs12>
                <v-text-field
                  :label="$t('shared.general.fields.subject')"
                  prepend-inner-icon="mdi-chevron-right"
                  small
                />
              </v-flex>

              <v-flex class="px-2 mt-5" xs12>
                <email-editor v-model="body" />
              </v-flex>
            </v-layout>
          </v-card-text>
        </v-form>
      </v-card>
    </v-flex>

    <v-flex xs12 lg6>
      <div v-if="loading" class="widget__loader">
				<v-progress-circular :size="30" :width="3" color="primary" indeterminate />
			</div>

      <v-card class="pa-3 height-100">
        <v-card-text>
          <p>Right</p>
        </v-card-text>
      </v-card>
    </v-flex>
  </v-layout>
</template>

<script>
import EmailEditor from '@components/email_templates/EmailEditor'

export default {
  name: 'RecruitmentMailer',
  components: {
    EmailEditor
  },
  data() {
    return {
      loading: false,
      body: ''
    }
  }
}
</script>
