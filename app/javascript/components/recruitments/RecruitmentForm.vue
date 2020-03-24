<template>
  <v-card class="pa-3">
    <v-card-title>
      <span class="headline">{{ $t(`components.recruitments.recruitmentForm.${formAction}Title`) }}</span>
    </v-card-title>

    <v-form ref="form" @submit.prevent="save">
      <v-card-text>
        <v-layout row wrap>
          <v-flex class="px-2" xs12 lg6>
            <status-select
              v-model="localRecruitment.status"
              :items="statuses"
              :rules="[vRequired]"
              append-icon="mdi-chevron-down"
              prepend-inner-icon="mdi-label-outline"
              :label="$t('shared.general.fields.status')"
              small
            />
          </v-flex>

          <v-flex class="pa-2" xs12>
            <h3 class="subtitle-1">{{ $t('components.recruitments.recruitmentForm.general') }}</h3>
          </v-flex>

          <v-flex class="px-2" xs12 lg4>
            <v-text-field
              v-model="localRecruitment.first_name"
              :rules="[vRequired]"
              :label="$t('shared.general.fields.firstName')"
              prepend-inner-icon="mdi-account-outline"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg4>
            <v-text-field
              v-model="localRecruitment.last_name"
              :rules="[vRequired]"
              :label="$t('shared.general.fields.lastName')"
              prepend-inner-icon="mdi-account-outline"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg4>
            <v-radio-group v-model="localRecruitment.gender" row>
              <v-radio :label="$t('components.recruitments.recruitmentForm.male')" value="male" />
              <v-radio :label="$t('components.recruitments.recruitmentForm.female')" value="female" />
            </v-radio-group>
          </v-flex>

          <v-flex class="pa-2" xs12 >
            <h3 class="subtitle-1">{{ $t('components.recruitments.recruitmentForm.contact') }}</h3>
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-text-field
              v-model="localRecruitment.email"
              :rules="[vRequired]"
              :label="$t('shared.general.fields.email')"
              prepend-inner-icon="mdi-at"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-text-field
              v-model="localRecruitment.phone"
              :label="$t('shared.general.fields.phoneNumber')"
              prepend-inner-icon="mdi-phone"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-combobox
              v-model="localRecruitment.group"
              :items="groups"
              :rules="[vRequired]"
              prepend-inner-icon="mdi-account-multiple-outline"
              chips
              :label="$t('shared.general.fields.group')"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-combobox
              v-model="localRecruitment.position"
              :items="positions"
              :rules="[vRequired]"
              append-icon="mdi-chevron-down"
              prepend-inner-icon="mdi-briefcase-outline"
              chips
              :label="$t('components.recruitments.recruitmentForm.position')"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-text-field
              v-model="localRecruitment.source"
              :label="$t('shared.general.fields.source')"
              prepend-inner-icon="mdi-email-receive-outline"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-menu
              :close-on-content-click="true"
              transition="scale-transition"
              :nudge-right="40"
              offset-y
              min-width="290px"
            >
              <template #activator="{ on }">
                <v-text-field
                  :value="localRecruitment.received_at"
                  :label="$t('components.recruitments.recruitmentForm.receivedDate')"
                  prepend-inner-icon="mdi-calendar"
                  :rules="[vRequired]"
                  readonly
                  v-on="on"
                />
              </template>

              <v-date-picker
                v-model="localRecruitment.received_at"
                :locale="$i18n.locale"
                no-title
                scrollable
              />
            </v-menu>
          </v-flex>

          <v-flex class="pa-2" xs12 >
            <h3 class="subtitle-1">{{ $t('components.recruitments.recruitmentForm.agreements') }}</h3>
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-checkbox
              :label="$t('components.recruitments.recruitmentForm.acceptCurrentProcessing')"
              v-model="localRecruitment.accept_current_processing"
              :rules="[vRequired]"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-checkbox
              :label="$t('components.recruitments.recruitmentForm.acceptFutureProcessing')"
              v-model="localRecruitment.accept_future_processing"
            />
          </v-flex>
        </v-layout>
      </v-card-text>

      <v-card-actions>
        <v-spacer />

        <v-btn
          type="reset"
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
          {{ $t('shared.buttons.save') }}
        </v-btn>
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script>
import { mapActions } from 'vuex'

import { RecruitDocument } from '@models/recruit_document'

import StatusSelect from '@components/recruitments/StatusSelect'

export default {
  name: 'RecruitmentForm',
  components: { StatusSelect },
  props: {
    groups: {
      type: Array,
      required: true,
      default: () => []
    },
    positions: {
      type: Array,
      required: true,
      default: () => []
    },
    statuses: {
      type: Array,
      required: true,
      default: () => []
    },
    recruitment: {
      type: RecruitDocument,
      required: false,
      default: () => new RecruitDocument()
    }
  },
  data() {
    return {
      localRecruitment: new RecruitDocument({ ...this.recruitment }),
    }
  },
  methods: {
    save() {
      if (!this.$refs.form.validate()) return

      this.create(this.localRecruitment)
        .then(data => {
          this.$router.push({
            name: 'recruitment_path',
            params: { publicRecruitId: data.public_recruit_id, id: data.id }
          })
        })
    },
    ...mapActions({
      create: 'RecruitDocumentsModule/create',
    })
  },
  computed: {
    formAction() {
      return this.localRecruitment.isPersisted ? 'update' : 'create'
    }
  }
}
</script>
