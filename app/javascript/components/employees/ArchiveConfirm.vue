<template>
  <v-card class="pa-3" data-cy="delete-modal">
    <v-card-title>
      <span class="headline">{{ $t('components.employees.archiveConfirm.title') }}</span>
    </v-card-title>

    <v-card-text>
      <p class="subtitle-1">{{ $t('components.employees.archiveConfirm.body') }}</p>
    </v-card-text>

    <v-date-picker
      v-model="archiveDate"
      :locale="$i18n.locale"
      value="2020-02-21"
      no-title
      scrollable
    />

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
        @click="archiveEmployee"
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
import { mapActions } from 'vuex'

export default {
  name: 'ArchiveConfirm',
  data(){
    return {
      archiveDate: ''
    }
  },
  methods: {
    closeDialog() {
      this.$emit('closeDialog')
    },
    archiveEmployee() {
      this.archive(this.archiveDate)
    },
    ...mapActions({
      archive: 'EmployeesModule/archive',
    }),
    redirectToIndex() {
      this.$router.push({ name: 'employees_path' })
    }
  }
}
</script>
