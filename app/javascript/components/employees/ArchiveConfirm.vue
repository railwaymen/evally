<template>
  <v-card class="pa-3" data-cy="delete-modal">
    <v-card-title>
      <span class="headline">{{ $t('components.employees.archiveConfirm.title') }}</span>
    </v-card-title>

    <v-card-text>
      <p class="subtitle-1">{{ $t('components.employees.archiveConfirm.body') }}</p>
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
        @click="archive"
        color="red darken-1"
        data-cy="btn-delete"
        text
      >
        {{ $t('shared.buttons.archive') }}
      </v-btn>
    </v-card-actions>

  </v-card>
</template>

<script>
export default {
  name: 'ArchiveConfirm',
  methods: {
    closeDialog() {
      this.$emit('closeDialog')
    },
    archive() {
      console.log('--archive---')
      // this.$store.dispatch('EmployeesModule/destroy')
      //   .then(this.redirectToIndex)
      //   .finally(this.closeDialog)
    },
    redirectToIndex() {
      this.$router.push({ name: 'employees_path' })
    }
  }
}
</script>
