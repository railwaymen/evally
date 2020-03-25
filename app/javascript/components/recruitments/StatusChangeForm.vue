<template>
  <v-card class="pa-3">
    <v-card-title>
      <span class="headline">{{ $t(`components.recruitments.statusChangeForm.title`) }}</span>
    </v-card-title>

    <v-form ref="form" @submit.prevent="save">
      <v-card-text>
        <v-layout row wrap>
          <v-flex class="pa-2" xs12>
            <p class="subtitle-1 text-center">
              Please provide additional information required to change status to:

              <v-chip
                :color="recruitDocument.status.color"
                small
                dark
                label
              >
                {{ recruitDocument.status.label }}
              </v-chip>
            </p>
          </v-flex>

          <v-flex
            v-for="field in recruitDocument.status.required_fields"
            :key="field.value"
            class="pa-2"
            xs12
          >
            <datetime-field
              v-if="field.type === 'datetime'"
              v-model="recruitDocument[field.value]"
              :label="field.label"
            />

            <v-textarea
              v-if="field.type === 'text'"
              v-model="recruitDocument[field.value]"
              :label="field.label"
              :rules="[vRequired]"
              rows="2"
            />
          </v-flex>
        </v-layout>
      </v-card-text>

      <v-card-actions>
        <v-spacer />
        <v-btn
          @click="closeDialog"
          color="grey darken-1"
          text
        >
          {{ $t('shared.buttons.cancel') }}
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
import { Status } from '@models/status'

import DatetimeField from '@components/shared/DatetimeField'

export default {
  name: 'StatusChangeForm',
  components: { DatetimeField },
  props: {
    recruitDocument: {
      type: RecruitDocument,
      required: true,
      default: () => new RecruitDocument()
    },
    prevStatus: {
      type: Status,
      required: true,
      default: () => new Status(),
    }
  },
  methods: {
    closeDialog() {
      this.recruitDocument.status = this.prevStatus
      this.$emit('closeDialog')
    },
    save() {
      this.$refs.form.validate()

      this.update(this.recruitDocument)
        .then(() => this.$emit('closeDialog'))
    },
    ...mapActions({
      update: 'RecruitDocumentsModule/update'
    })
  },
}
</script>
