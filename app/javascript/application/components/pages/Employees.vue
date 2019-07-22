<template>
  <section class="panel">
    <v-layout row>
      <v-flex>
        <h2 class="panel__heading">{{ $t('employees.title') }}</h2>
      </v-flex>

      <v-flex>
        <div class="panel__action-bar">
          <v-tooltip bottom>
            <v-btn @click="build" color="green" slot="activator" icon flat>
              <v-icon>add</v-icon>
            </v-btn>
            <span>{{ $t('employees.buttons.add_new') }}</span>
          </v-tooltip>
        </div>
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
import openerBus from '@/lib/opener_bus'

import EmployeesTable from '@/components/employees/EmployeesTable'

export default {
  name: 'Employees',
  components: { EmployeesTable },
  methods: {
    build() {
      this.$store.commit('EmployeesStore/clear')
      openerBus.openFormModal({ model: 'employee', action: 'create', maxWidth: 500 })
    }
  },
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
