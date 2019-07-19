<template>
  <section class="panel">
    <v-layout row>
      <v-flex>
        <h2 class="panel__heading">{{ $t('employees.title') }}</h2>
      </v-flex>
    </v-layout>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <employees-table></employees-table>
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapGetters } from 'vuex'

import EmployeesTable from '@/components/employees/EmployeesTable'

export default {
  name: 'Employees',
  components: { EmployeesTable },
  computed: {
    ...mapGetters({
      employees: 'EmployeesStore/employees',
      employee: 'EmployeesStore/employee'
    })
  },
  created() {
    this.$store.dispatch('EmployeesStore/index', { state: 'hired' })
      .catch(error => {
        this.flash({ error: this.$root.$t('employees.flashes.fetch.error', { reason: this.renderError(error.response) }) })
      })
  },
  beforeDestroy() {
    this.$store.commit('EmployeesStore/clear')
  }
}
</script>
