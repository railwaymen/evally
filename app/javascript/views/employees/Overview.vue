<template>
  <v-layout row wrap>
    <v-flex xs12 lg6>
      <h2 class="headline text-center mb-4">{{ $t('views.employees.overview.employment') }}</h2>

      <v-layout row wrap>
        <v-flex xs4>
          <numbers-tile
            :title="$t('views.employees.overview.tiles.averageEmployment')"
            :loading="loading"
          >
            <template v-if="analytics.averageEmployment.years > 0" #left-side>
              <h3 class="numbers-tile__value">{{ analytics.averageEmployment.years }}</h3>
              <h4 class="numbers-tile__subtitle">
                {{ $tc('views.employees.overview.tiles.years', analytics.averageEmployment.years, { n: analytics.averageEmployment.years }) }}
              </h4>
            </template>

            <template #right-side>
              <h3 class="numbers-tile__value">{{ analytics.averageEmployment.months }}</h3>
              <h4 class="numbers-tile__subtitle">
                {{ $tc('views.employees.overview.tiles.months', analytics.averageEmployment.months, { n: analytics.averageEmployment.months }) }}
              </h4>
            </template>
          </numbers-tile>
        </v-flex>

        <v-flex xs4>
          <numbers-tile
            :title="$t('views.employees.overview.tiles.employees')"
            :loading="loading"
          >
            <template #left-side>
              <h3 class="numbers-tile__value">{{ analytics.hired_employees_number }}</h3>
              <h4 class="numbers-tile__subtitle">
                {{ $t('views.employees.overview.tiles.hired') }}
              </h4>
            </template>

            <template #right-side>
              <h3 class="numbers-tile__value">{{ analytics.archived_employees_number }}</h3>
              <h4 class="numbers-tile__subtitle">
                {{ $t('views.employees.overview.tiles.archived') }}
              </h4>
            </template>
          </numbers-tile>
        </v-flex>

        <v-flex xs4>
          <numbers-tile
            :title="$t('views.employees.overview.tiles.changes')"
            :loading="loading"
          >
            <template #left-side>
              <h3 class="numbers-tile__value">{{ analytics.new_employees_number_this_year }}</h3>
              <h4 class="numbers-tile__subtitle">
                {{ $t('views.employees.overview.tiles.new') }}
              </h4>
            </template>

            <template #right-side>
              <h3 class="numbers-tile__value">{{ analytics.archived_employees_number_this_year }}</h3>
              <h4 class="numbers-tile__subtitle">
                {{ $t('views.employees.overview.tiles.archived') }}
              </h4>
            </template>
          </numbers-tile>
        </v-flex>

        <v-flex xs12>
          <positions-chart-widget
            :chartData="positionsChartData"
            :groups="groups"
            :loading="loading"
          />
        </v-flex>
      </v-layout>
    </v-flex>

    <v-flex xs12 lg6>
      <h2 class="headline text-center mb-4">{{ $t('views.employees.overview.evaluations') }}</h2>
    </v-flex>
  </v-layout>
</template>

<script>
import { mapGetters } from 'vuex'

import NumbersTile from '@components/shared/NumbersTile'
import PositionsChartWidget from '@components/employees/PositionsChartWidget'

export default {
  name: 'EmployeesOverview',
  components: { NumbersTile, PositionsChartWidget },
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
