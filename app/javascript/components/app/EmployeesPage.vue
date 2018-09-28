<template>
  <section class="panel">
    <v-layout row>
      <v-flex xs6>
        <h2 class="panel__heading">Employees</h2>
      </v-flex>

      <v-flex xs6>
        <div class="panel__action-bar">
          <v-btn @click="build" color="green" flat>
            <v-icon>add</v-icon> New employee
          </v-btn>

          <template v-if="employee.isExisting()">
            <v-btn @click="edit" flat>
              <v-icon>edit</v-icon> Edit
            </v-btn>
            <v-btn color="red" flat>
              <v-icon>delete</v-icon> Delete
            </v-btn>
          </template>

        </div>
      </v-flex>
    </v-layout>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout row>
          <v-flex xs3>
            <search-box></search-box>
          </v-flex>

          <v-flex xs9>
            <employee-card></employee-card>
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapGetters } from 'vuex'

import openerBus from '../../lib/opener_bus'

import EmployeeCard from './employees/EmployeeCard'
import SearchBox from './employees/SearchBox'

export default {
  name: 'EmployeesPage',
  components: { EmployeeCard, SearchBox },
  methods: {
    build() {
      this.$store.commit('EmployeesStore/clear')
      openerBus.openFormModal({ model: 'employee', action: 'create', maxWidth: 500 })
    },
    edit() {
      openerBus.openFormModal({ model: 'employee', action: 'edit', maxWidth: 500 })
    }
  },
  computed: {
    ...mapGetters({
      employee: 'EmployeesStore/employee',
    })
  }
}
</script>
