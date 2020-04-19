<template>
  <v-layout row wrap>
    <v-flex xs10 offset-xs1 lg3 offset-lg0>
      <employee-sidebar
        :employee="employee"
        :evaluations="evaluations"
        :positionChanges="positionChanges"
      />
    </v-flex>

    <v-flex xs12 lg9>
      <div v-if="$route.name === 'employee_path'" class="box">
        <v-layout row>
          <v-flex xs12>
            <h4 class="box__header">
              {{ $t('views.employees.show.instruction') }}
            </h4>
          </v-flex>
        </v-layout>
      </div>

      <router-view v-else />
    </v-flex>
  </v-layout>
</template>

<script>
import { mapState } from 'vuex'

import EmployeeSidebar from '@components/employees/EmployeeSidebar'

export default {
  name: 'Employee',
  components: { EmployeeSidebar },
  computed: {
    ...mapState('EmployeesModule', [
      'employees',
      'evaluations',
      'positionChanges'
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
