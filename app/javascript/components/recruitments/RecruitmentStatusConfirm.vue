<template>
  <v-card class="pa-3">
    <v-card-title>
      <span class="headline">{{ $t(`components.recruitments.recruitmentStatusConfirm.${action}Title`) }}</span>
    </v-card-title>

    <v-card-text>
      <p
        v-html="$t(`components.recruitments.recruitmentStatusConfirm.${action}Body`, { name: recruitment.name })"
        class="subtitle-1"
      />
    </v-card-text>

    <v-card-actions>
      <v-spacer />

      <v-btn
        @click="closeDialog"
        color="grey darken-1"
        data-cy="btn-cancel"
        text
      >
        {{ $t('shared.buttons.cancel') }}
      </v-btn>

      <v-btn
        @click="changeStatus"
        :color="action === 'start' ? 'green' : 'primary'"
        data-cy="btn-delete"
        text
      >
        {{ $t(`shared.buttons.${action}`) }}
      </v-btn>
    </v-card-actions>

  </v-card>
</template>

<script>
import { mapActions } from 'vuex'

import { Recruitment } from '@models/recruitment'

export default {
  name: 'RecruitmentStatusConfirm',
  props: {
    recruitment: {
      type: Recruitment,
      required: true
    },
    action: {
      type: String,
      required: true
    }
  },
  methods: {
    ...mapActions('RecruitmentsModule', [
      'startRecruitment',
      'completeRecruitment'
    ]),
    closeDialog() {
      this.$emit('closeDialog')
    },
    changeStatus() {
      const actionsMap = {
        start: this.startRecruitment,
        complete: this.completeRecruitment
      }

      actionsMap[this.action](this.recruitment)
        .then(this.closeDialog)
    }
  }
}
</script>
