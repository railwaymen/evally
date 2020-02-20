<template>
  <v-card class="pa-3" data-cy="delete-modal">
    <v-card-title>
      <span class="headline">{{ $t('components.employees.archiveForm.title') }}</span>
    </v-card-title>

    <v-card-text>
      <p class="subtitle-1">{{ $t('components.employees.archiveForm.body') }}</p>
    </v-card-text>

       <v-menu
          ref="menu"
          v-model="menu"
          :close-on-content-click="true"
          :nudge-right="40"
          transition="scale-transition"
          offset-y
          min-width="290px"
        >
      <template v-slot:activator="{ on }">
      <v-text-field
        :value="archiveDate"
        prepend-inner-icon="mdi-calendar"
        readonly
        v-on="on"
      />
    </template>
    <v-date-picker
      v-model="archiveDate"
      :locale="$i18n.locale"
      no-title
      scrollable
    />
    </v-menu>

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
  name: 'ArchiveForm',
  data(){
    return {
      menu: false,
      archiveDate: new Date().format('YYYY-MM-DD')
    }
  },
  methods: {
    closeDialog() {
      this.$emit('closeDialog')
    },
    archiveEmployee() {
      this.archive(this.archiveDate)
      this.closeDialog()
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
