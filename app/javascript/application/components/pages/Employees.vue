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

          <template v-if="employee.isExisting()">
            <v-tooltip bottom>
              <v-btn @click="permalink" slot="activator" icon flat>
                <v-icon>link</v-icon>
              </v-btn>
              <span>{{ $t('employees.buttons.permalink') }}</span>
            </v-tooltip>

            <v-tooltip v-for="item in menuItems" :key="`item_${item.id}`" bottom>
              <v-btn @click="item.action" :color="item.color" slot="activator" icon flat>
                <v-icon>{{ item.icon }}</v-icon>
              </v-btn>
              <span>{{ $t(`employees.buttons.${item.name}`) }}</span>
            </v-tooltip>
          </template>

          <v-tooltip class="divider-before" bottom>
            <v-btn @click="isSidebarVisible = !isSidebarVisible" slot="activator" icon flat>
              <v-icon>{{ isSidebarVisible ? 'visibility_off' : 'visibility' }}</v-icon>
            </v-btn>
            <span>{{ isSidebarVisible ? $t('buttons.hide') : $t('buttons.show') }} sidebar</span>
          </v-tooltip>

        </div>
      </v-flex>
    </v-layout>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout wrap row>
          <v-flex v-if="isSidebarVisible" xs10 offset-xs1 lg3 offset-lg0>
            <employee-search-box></employee-search-box>
          </v-flex>

          <v-flex xs12 :lg9="isSidebarVisible" :lg12="!isSidebarVisible">
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
      isSidebarVisible: true,
      menuItems: [
        { id: 0, name: 'edit', icon: 'edit', action: this.edit, color: 'black' },
        { id: 10, name: 'archive', icon: 'how_to_vote', action: this.archive, color: 'black' },
        { id: 20, name: 'delete', icon: 'delete', action: this.remove, color: 'red' }
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
      openerBus.openFormModal({ model: 'employee', action: 'archive', maxWidth: 600 })
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
      .catch(error => {
        this.flash({ error: this.$t('employees.flashes.fetch.error', { reason: this.renderError(error.response) }) })
      })

    this.$store.dispatch('EvaluationsStore/index', { state: 'completed' })
      .catch(error => {
        this.flash({ error: this.$t('evaluations.flashes.fetch.error', { reason: this.renderError(error.response) }) })
      })
  },
  beforeDestroy() {
    this.$store.commit('EvaluationsStore/clear')
  }
}
</script>
