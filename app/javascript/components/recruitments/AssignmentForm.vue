<template>
  <v-card class="pa-3">
    <v-card-title>
      <span class="headline">{{ $t(`components.recruitments.assignmentForm.title`) }}</span>
    </v-card-title>

    <v-form ref="form" @submit.prevent="save">
      <v-card-text>
        <v-layout row wrap>
          <v-flex class="px-2" xs12>
            <v-select
              v-model="recruitment"
              :items="ongoingRecruitments.models"
              :rules="[vRequired]"
              :label="$t('shared.general.fields.recruitment')"
              prepend-inner-icon="mdi-notebook-outline"
              item-text="name"
              return-object
            />
          </v-flex>

          <v-flex class="px-2" xs12>
            <v-select
              v-model="stage"
              :items="recruitment.stages"
              :rules="[vRequired]"
              :label="$t('shared.general.fields.stage')"
              prepend-inner-icon="mdi-source-commit"
              :disabled="recruitment.isNew"
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
          :disabled="recruitment.isNew || !stage"
          text
        >
          {{ $t('shared.buttons.assign') }}
        </v-btn>
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script>
import { mapActions, mapState } from 'vuex'

import { Recruitment } from '@models/recruitment'

export default {
  name: 'RecruitmentAssignmentForm',
  data() {
    return {
      recruitment: new Recruitment(),
      stage: ''
    }
  },
  methods: {
    ...mapActions('RecruitDocumentsModule', [
      'assignRecruitment'
    ]),
    closeDialog() {
      this.$emit('closeDialog')
    },
    save() {
      const params = {
        recruitment_id: this.recruitment.id,
        stage: this.stage
      }

      this.assignRecruitment(params)
        .then(this.closeDialog)
    }
  },
  computed: {
    ...mapState('RecruitDocumentsModule', [
      'ongoingRecruitments'
    ])
  }
}
</script>
