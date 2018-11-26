<template>
  <section class="panel">
    <v-layout row>
      <v-flex>
        <h2 class="panel__heading">Employees</h2>
      </v-flex>

      <v-flex>
        <div class="panel__action-bar">
          <v-tooltip bottom>
            <v-btn @click="build" color="green" slot="activator" icon flat>
              <v-icon>add</v-icon>
            </v-btn>
            <span>New employee</span>
          </v-tooltip>

          <template v-if="employee.isExisting()">
            <v-tooltip v-if="setting.public_view_enabled" bottom>
              <v-btn @click="permalink" slot="activator" icon flat>
                <v-icon>link</v-icon>
              </v-btn>
              <span>Get permalink</span>
            </v-tooltip>

            <v-tooltip v-for="item in menuItems" :key="`item_${item.id}`" bottom>
              <v-btn @click="item.action" :color="item.color" slot="activator" icon flat>
                <v-icon>{{ item.icon }}</v-icon>
              </v-btn>
              <span>{{ item.name }}</span>
            </v-tooltip>
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
  data() {
    return {
      menuItems: [
        { id: 0, name: 'Edit employee', icon: 'edit', action: this.edit, color: 'black' },
        { id: 10, name: 'Archive employee', icon: 'how_to_vote', action: this.archive, color: 'black' },
        { id: 20, name: 'Delete employee', icon: 'delete', action: this.remove, color: 'red' }
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
