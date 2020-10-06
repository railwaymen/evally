<template>
  <v-card class="pa-3" data-cy="delete-modal">
    <v-card-title>
      <span class="headline">{{ $t('components.emailTemplates.deleteConfirm.title') }}</span>
    </v-card-title>

    <v-card-text>
      <p class="subtitle-1">{{ $t('components.emailTemplates.deleteConfirm.body') }}</p>
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
export default {
  name: 'DeleteConfirm',
  methods: {
    closeDialog() {
      this.$emit('closeDialog')
    },
    destroy() {
      this.$store.dispatch('EmailTemplatesModule/removeTemplate')
        .then(() => this.$router.push({ name: 'email_templates_path' }))
        .finally(this.closeDialog)
    }
  }
}
</script>
