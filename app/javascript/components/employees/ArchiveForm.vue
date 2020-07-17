<template>
  <v-card class="pa-3" data-cy="delete-modal">
    <v-card-title>
      <span class="headline">{{ $t('components.employees.archiveForm.title') }}</span>
    </v-card-title>

    <v-form @submit.prevent="archiveEmployee">
      <v-card-text>
        <p
          class="subtitle-1 text-center mb-0"
          v-html="$t('components.employees.archiveForm.body', { name: localEmployee.fullname })"
        />

        <p class="subtitle-1 text-center">
          {{ $t('components.employees.archiveForm.dateRequest') }}
        </p>

        <v-menu
          ref="menu"
          v-model="menu"
          :close-on-content-click="false"
          :nudge-right="40"
          transition="scale-transition"
          offset-y
          min-width="290px"
        >
          <template v-slot:activator="{ on }">
            <v-text-field
              :value="localEmployee.archivedOn"
              :label="$t('components.employees.archiveForm.archivedOn')"
              prepend-inner-icon="mdi-calendar"
              :rules="[vRequired]"
              readonly
              v-on="on"
            />
          </template>

          <v-date-picker
            v-model="localEmployee.archivedDate"
            @input="menu = false"
            :min="localEmployee.hiredDate"
            :locale="$i18n.locale"
            no-title
            scrollable
          />
        </v-menu>
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
          color="orange"
          text
        >
          {{ $t('shared.buttons.archive') }}
        </v-btn>
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script>
import { Employee } from '@models/employee'

export default {
  name: 'ArchiveForm',
  props: {
    employee: {
      type: Employee,
      required: true,
      default: () => new Employee()
    }
  },
  data(){
    return {
      localEmployee: new Employee({ ...this.employee }),
      menu: false
    }
  },
  methods: {
    closeDialog() {
      this.$emit('closeDialog')
    },
    archiveEmployee() {
      this.$store.dispatch('EmployeesModule/archiveEmployee', this.localEmployee)
        .then(this.closeDialog)
    }
  }
}
</script>
