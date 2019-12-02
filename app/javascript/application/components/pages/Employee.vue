<template>
  <section class="panel">
    <v-layout row>
      <v-flex>
        <h2 class="panel__heading">{{ $t('employees.title') }}</h2>
      </v-flex>

      <v-flex>
        <div class="panel__action-bar">
          <v-tooltip v-for="item in menuItems" :key="`item_${item.id}`" bottom>
            <v-btn @click="item.action" :color="item.color" slot="activator" :data-cy="`btn-${item.action.name.split(' ')[1]}`" icon flat>
              <v-icon>{{ item.icon }}</v-icon>
            </v-btn>
            <span>{{ $t(`employees.buttons.${item.name}`) }}</span>
          </v-tooltip>
        </div>
      </v-flex>
    </v-layout>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout wrap row>
          <v-flex xs10 offset-xs1 lg3 offset-lg0>
            <positions-history />
          </v-flex>

          <v-flex xs12 lg9>
            <employee-evaluation-box />
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
import PositionsHistory from '@/components/employees/PositionsHistory'

export default {
  name: 'Employee',
  components: { EmployeeEvaluationBox, PositionsHistory },
  data() {
    return {
      menuItems: [
        { id: 0, name: 'back', icon: 'undo', action: this.back, color: 'black' },
        { id: 1, name: 'permalink', icon: 'link', action: this.permalink, color: 'black' },
        { id: 2, name: 'edit', icon: 'edit', action: this.edit, color: 'black' },
        { id: 3, name: 'archive', icon: 'how_to_vote', action: this.archive, color: 'black' },
        { id: 4, name: 'delete', icon: 'delete', action: this.remove, color: 'red' }
      ]
    }
  },
  methods: {
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
    },

    back() {
      this.$store.commit('EvaluationsStore/clear')
      this.$router.back()
    }
  },
  computed: {
    ...mapGetters({
      employee: 'EmployeesStore/employee'
    })
  },
  created() {
    this.$store.dispatch('EmployeesStore/show', this.$route.params.id)
      .then(() => this.$vuetify.goTo(0))
      .catch(error => {
        this.flash({ error: this.$root.$t('employees.flashes.fetch.error', { reason: this.renderError(error.response) }) })
      })
  }
}
</script>
