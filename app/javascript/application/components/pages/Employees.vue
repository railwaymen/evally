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
            <v-btn v-if="setting.public_view_enabled" @click="permalink" flat>
              <v-icon>link</v-icon> Permalink
            </v-btn>
            <v-btn @click="edit" flat>
              <v-icon>edit</v-icon> Edit
            </v-btn>
            <v-btn @click="archive" flat>
              <v-icon>how_to_vote</v-icon> Archive
            </v-btn>
            <v-btn @click="remove" color="red" flat>
              <v-icon>delete</v-icon> Delete
            </v-btn>
          </template>

        </div>
      </v-flex>
    </v-layout>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout wrap row>
          <v-flex xs10 offset-xs1 lg3 offset-lg0>
            <employee-search-box></employee-search-box>
          </v-flex>

          <v-flex xs12 lg9>
            <employee-evaluation-box></employee-evaluation-box>
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapGetters } from 'vuex'

import openerBus from '@/lib/opener_bus'

import EmployeeEvaluationBox from '@/components/employees/EmployeeEvaluationBox'
import EmployeeSearchBox from '@/components/employees/EmployeeSearchBox'

export default {
  name: 'Employees',
  components: { EmployeeEvaluationBox, EmployeeSearchBox },
  methods: {
    build() {
      this.$store.commit('EmployeesStore/clear')
      openerBus.openFormModal({ model: 'employee', action: 'create', maxWidth: 500 })
    },
    permalink() {
      openerBus.openFormModal({ model: 'info', action: 'permalink', maxWidth: 600 })
    },
    edit() {
      openerBus.openFormModal({ model: 'employee', action: 'edit', maxWidth: 500 })
    },
    archive() {
      openerBus.openFormModal({ model: 'employee', action: 'archive', maxWidth: 500 })
    },
    remove() {
      openerBus.openDestroyModal({ model: 'employee', action: 'delete', maxWidth: 500 })
    }
  },
  computed: {
    ...mapGetters({
      employee: 'EmployeesStore/employee',
      setting: 'AuthStore/setting'
    })
  },
  created() {
    this.$store.dispatch('EmployeesStore/index', { state: 'hired' })
      .catch( error => {
        this.flash({ error: 'Employees cannot be loaded due to some error: ' + this.renderError(error.response) })
      })

    this.$store.dispatch('EvaluationsStore/index', { state: 'completed' })
      .catch( error => {
        this.flash({ error: 'Evaluations cannot be loaded due to some error: ' + this.renderError(error.response) })
      })
  },
  beforeDestroy() {
    this.$store.commit('EvaluationsStore/clear')
  }
}
</script>
