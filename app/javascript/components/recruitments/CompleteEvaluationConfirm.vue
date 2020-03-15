<template>
  <v-card class="pa-3" data-cy="delete-modal">
    <v-card-title>
      <span class="headline">{{ $t('components.evaluations.completeForm.title') }}</span>
    </v-card-title>

    <v-card-text>
      <p class="subtitle-1">
        {{ $t('components.evaluations.completeForm.question') }}<br />
        {{ $t('components.evaluations.completeForm.warning') }}
      </p>
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
        color="green darken-1"
        data-cy="btn-delete"
        text
      >
        {{ $t('shared.buttons.complete') }}
      </v-btn>
    </v-card-actions>

  </v-card>
</template>

<script>
export default {
  name: 'CompleteEvaluationConfirm',
  methods: {
    closeDialog() {
      this.$emit('closeDialog')
    },
    destroy() {
      this.$store.dispatch('RecruitDocumentsModule/completeEvaluation')
        .finally(this.closeDialog)
    }
  }
}
</script>
