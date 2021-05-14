<template>
  <v-card class="pa-3" data-cy="delete-modal">
    <v-card-title>
      <span class="headline">{{ $t('components.recruitments.deleteRecruitmentConfirm.title') }}</span>
    </v-card-title>

    <v-card-text>
      <p
        v-html="$t('components.recruitments.deleteRecruitmentConfirm.body', { name: recruitment.name })"
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
        @click="destroy"
        color="red darken-1"
        data-cy="btn-delete"
        text
      >
        {{ $t('shared.buttons.delete') }}
      </v-btn>
    </v-card-actions>

  </v-card>
</template>

<script>
import { Recruitment } from '@models/recruitment'

export default {
  name: 'DeleteRecruitmentConfirm',
  props: {
    recruitment: {
      type: Recruitment,
      required: true
    }
  },
  methods: {
    closeDialog() {
      this.$emit('closeDialog')
    },
    destroy() {
      this.$store.dispatch('RecruitmentsModule/removeRecruitment', this.recruitment)
        .then(this.closeDialog)
    }
  }
}
</script>
