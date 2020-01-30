<template>
  <v-card class="pa-3" data-cy="delete-modal">
    <v-card-title>
      <span class="headline">{{ $t('destroy_modals.evaluation.title') }}</span>
    </v-card-title>

    <v-card-text>
      <p class="subheading">{{ $t('destroy_modals.evaluation.confirm') }}</p>
    </v-card-text>

    <v-card-actions>
      <v-spacer></v-spacer>
      <v-btn
        @click="closeDialog"
        color="grey darken-1"
        data-cy="btn-cancel"
        flat
      >
        {{ $t('buttons.cancel') }}
      </v-btn>

      <v-btn
        @click="destroy"
        color="red darken-1"
        data-cy="btn-delete"
        flat
      >
        {{ $t('buttons.delete') }}
      </v-btn>
    </v-card-actions>

  </v-card>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  name: 'DeleteConfirm',
  methods: {
    closeDialog() {
      this.$emit('closeDialog')
    },
    destroy() {
      this.$store.dispatch('DraftsModule/destroy')
        .finally(this.closeDialog)
    }
  }
}
</script>
