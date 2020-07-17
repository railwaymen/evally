<template>
  <v-card class="pa-3" data-cy="delete-modal">
    <v-card-title>
      <span class="headline">{{ $t('components.employees.restoreConfirm.title') }}</span>
    </v-card-title>

    <v-card-text>
      <p
        class="subtitle-1"
        v-html="$t('components.employees.restoreConfirm.body', { name: employee.fullname })"
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
        @click="restore"
        color="orange"
        text
      >
        {{ $t('shared.buttons.restore') }}
      </v-btn>
    </v-card-actions>

  </v-card>
</template>

<script>
import { Employee } from '@models/employee'

export default {
  name: 'RestoreConfirm',
  props: {
    employee: {
      type: Employee,
      required: true,
      default: () => new Employee()
    }
  },
  methods: {
    closeDialog() {
      this.$emit('closeDialog')
    },
    restore() {
      this.$store.dispatch('EmployeesModule/restoreEmployee', this.employee)
        .then(this.closeDialog)
    }
  }
}
</script>
