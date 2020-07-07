<template>
  <v-layout row wrap>
    <v-flex xs10 offset-xs1 lg3 offset-lg0>
      <employee-sidebar
        :employee="employee"
        :evaluations="evaluations"
        :positionChanges="positionChanges"
        :employeePolicy="employeePolicy"
        :loading="fetchLoading"
      />
    </v-flex>

    <v-flex xs12 lg9>
      <div v-if="$route.name === 'employee_path'" class="box">
        <v-layout row>
          <v-flex xs12>
            <h4 class="box__header">
              {{ employeePolicy.canSeeEvaluation ? $t('views.employees.show.instruction') : $t('views.employees.show.smile') }}
            </h4>
          </v-flex>
        </v-layout>
      </div>

      <router-view v-else />
    </v-flex>
  </v-layout>
</template>

<script>
import { mapGetters, mapState } from 'vuex'

import EmployeeSidebar from '@components/employees/EmployeeSidebar'

export default {
  name: 'Employee',
  components: { EmployeeSidebar },
  computed: {
    ...mapState('EmployeesModule', [
      'employee',
      'evaluations',
      'positionChanges'
    ]),
    ...mapGetters('EmployeesModule', [
      'fetchLoading',
      'employeePolicy'
    ])
  },
  created() {
    this.$store.dispatch('EmployeesModule/fetchEmployee', this.$route.params.employeeId)
  },
  destroyed() {
    this.$store.commit('EmployeesModule/CLEAR_EMPLOYEE')
  }
}
</script>
