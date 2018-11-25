<template>
  <section class="panel">
    <v-layout row>
      <v-flex xs6>
        <h2 class="panel__heading">Employees</h2>
      </v-flex>

      <v-flex xs6>
        <div class="panel__action-bar">
          <v-btn @click="build" color="green" flat>
            <v-icon>add</v-icon> New
          </v-btn>

          <v-menu
            :disabled="!employee.isExisting()"
            transition="slide-y-transition"
            offset-y bottom left
          >
            <v-btn :disabled="!employee.isExisting()" color="primary" slot="activator" icon flat>
              <v-icon>more_vert</v-icon>
            </v-btn>

            <v-list>
              <v-list-tile v-if="setting.public_view_enabled" @click="permalink">
                <v-list-tile-action>
                  <v-icon>link</v-icon>
                </v-list-tile-action>
                <v-list-tile-title>Permalink</v-list-tile-title>
              </v-list-tile>

              <v-list-tile v-for="item in menuItems" :key="`item_${item.id}`" @click="item.action">
                <v-list-tile-action>
                  <v-icon>{{ item.icon }}</v-icon>
                </v-list-tile-action>
                <v-list-tile-title>{{ item.name }}</v-list-tile-title>
              </v-list-tile>
            </v-list>
          </v-menu>
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
  data() {
    return {
      menuItems: [
        { id: 0, name: 'Edit', icon: 'edit', action: this.edit },
        { id: 10, name: 'Archive', icon: 'how_to_vote', action: this.archive },
        { id: 20, name: 'Delete', icon: 'delete', action: this.remove }
      ]
    }
  },
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
