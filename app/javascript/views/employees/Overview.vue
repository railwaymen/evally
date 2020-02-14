<template>
  <v-layout row wrap>
    <v-flex xs12 lg9>
      <positions-chart-widget
        :chartData="positionsChartData"
        :groups="groups"
        :loading="loading"
      />
    </v-flex>

    <v-flex xs12 lg3>
      <average-employment-widget
        :analytics="analytics"
        :loading="loading"
      />
    </v-flex>
  </v-layout>
</template>

<script>
import { mapGetters } from 'vuex'

import AverageEmploymentWidget from '@components/employees/AverageEmploymentWidget'
import PositionsChartWidget from '@components/employees/PositionsChartWidget'

export default {
  name: 'EmployeesOverview',
  components: { AverageEmploymentWidget, PositionsChartWidget },
  computed: {
    ...mapGetters({
      positionsChartData: 'EmployeesOverviewModule/positionsChartData',
      groups: 'EmployeesOverviewModule/groups',
      analytics: 'EmployeesOverviewModule/analytics',
      loading: 'EmployeesOverviewModule/loading'
    })
  },
  created() {
    this.$store.dispatch('EmployeesOverviewModule/overview')
  }
}
</script>
