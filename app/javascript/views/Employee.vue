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
              Select evaluation from list to see details.
            </h4>
          </v-flex>
        </v-layout>
      </div>

      <router-view v-else />
    </v-flex>
  </v-layout>
</template>

<script>
import { mapGetters } from 'vuex'

import EmployeeSidebar from '@components/employees/EmployeeSidebar'

export default {
  name: 'Employee',
  components: { EmployeeSidebar },
  computed: {
    ...mapGetters({
      employee: 'EmployeesModule/employee',
      evaluations: 'EmployeesModule/evaluations',
      positionChanges: 'EmployeesModule/positionChanges'
    })
  },
  created() {
    this.$store.dispatch('EmployeesModule/show', this.$route.params.employeeId)
  },
  beforeDestroy() {
    this.$store.commit('EmployeesModule/resetItem')
  }
}
</script>
