<template>
  <v-layout row wrap>
    <v-flex xs12 lg9>
      <div class="widget widget--border-primary">
        <h3 class="widget__header">
          Employees by Positions
        </h3>

        <div class="widget__body">
          <div v-if="loading" class="widget__loader">
            <v-progress-circular :size="30" :width="3" color="primary" indeterminate />
          </div>

          <positions-chart
            v-else
            :chart-data="positionsChartData"
            :groups="groups"
          />
        </div>
      </div>
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
import PositionsChart from '@components/employees/PositionsChart'

export default {
  name: 'EmployeesOverview',
  components: { AverageEmploymentWidget, PositionsChart },
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
