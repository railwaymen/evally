<template>
  <v-layout row wrap>
    <v-flex xs12 lg6>
      <h2 class="size-27 text-center font-weight-light mb-4">
        {{ $t('views.employees.overview.employment') }}
      </h2>

      <v-layout row wrap>
        <v-flex xs4>
          <numbers-tile
            :title="$t('views.employees.overview.tiles.averageEmployment')"
            :loading="loading"
            background-color="#e6e5f7"
          >
            <template v-if="employeesAnalytics.averageEmployment.years > 0" #left-side>
              <h3 class="numbers-tile__value">{{ employeesAnalytics.averageEmployment.years }}</h3>
              <h4 class="numbers-tile__subtitle">
                {{ $tc('views.employees.overview.tiles.years', employeesAnalytics.averageEmployment.years) }}
              </h4>
            </template>

            <template #right-side>
              <h3 class="numbers-tile__value">{{ employeesAnalytics.averageEmployment.months }}</h3>
              <h4 class="numbers-tile__subtitle">
                {{ $tc('views.employees.overview.tiles.months', employeesAnalytics.averageEmployment.months) }}
              </h4>
            </template>
          </numbers-tile>
        </v-flex>

        <v-flex xs4>
          <numbers-tile
            :title="$t('views.employees.overview.tiles.employees')"
            :loading="loading"
            background-color="#e6e5f7"
          >
            <template #left-side>
              <h3 class="numbers-tile__value">{{ employeesAnalytics.hired_employees_number }}</h3>
              <h4 class="numbers-tile__subtitle">
                {{ $t('views.employees.overview.tiles.hired') }}
              </h4>
            </template>

            <template #right-side>
              <h3 class="numbers-tile__value">{{ employeesAnalytics.archived_employees_number }}</h3>
              <h4 class="numbers-tile__subtitle">
                {{ $t('views.employees.overview.tiles.archived') }}
              </h4>
            </template>
          </numbers-tile>
        </v-flex>

        <v-flex xs4>
          <numbers-tile
            :title="$t('views.employees.overview.tiles.changesThisYear', { year: $moment().year() })"
            :loading="loading"
            background-color="#e6e5f7"
          >
            <template #left-side>
              <h3 class="numbers-tile__value">{{ employeesAnalytics.new_employees_number_this_year }}</h3>
              <h4 class="numbers-tile__subtitle">
                {{ $t('views.employees.overview.tiles.new') }}
              </h4>
            </template>

            <template #right-side>
              <h3 class="numbers-tile__value">{{ employeesAnalytics.archived_employees_number_this_year }}</h3>
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

        <v-flex xs12>
          <employees-past-year-chart-widget
            :chartData="employeesPastYearChartData"
            :loading="loading"
          />
        </v-flex>
      </v-layout>
    </v-flex>

    <v-flex xs12 lg6>
      <h2 class="size-27 text-center font-weight-light mb-4">
        {{ $t('views.employees.overview.evaluations') }}
      </h2>

      <v-layout row wrap>
        <v-flex xs4>
          <numbers-tile
            :title="$t('views.employees.overview.tiles.averageEvaluations')"
            :loading="loading"
            background-color="#f1efe2"
          >
            <template #full-width>
              <h3 class="numbers-tile__value">{{ evaluationsAnalytics.average_evaluations }}</h3>
              <h4 class="numbers-tile__subtitle">
                {{ $t('views.employees.overview.tiles.evaluationsPerEmployee') }}
              </h4>
            </template>
          </numbers-tile>
        </v-flex>

        <v-flex xs4>
          <numbers-tile
            :title="$t('views.employees.overview.tiles.allEvaluations')"
            :loading="loading"
            background-color="#f1efe2"
          >
            <template #full-width>
              <h3 class="numbers-tile__value">{{ evaluationsAnalytics.total_evaluations_number }}</h3>
              <h4 class="numbers-tile__subtitle">
                {{ $t('views.employees.overview.tiles.completed') }}
              </h4>
            </template>
          </numbers-tile>
        </v-flex>

        <v-flex xs4>
          <numbers-tile
            :title="$t('views.employees.overview.tiles.evaluationsThisYear', { year: $moment().year() })"
            :loading="loading"
            background-color="#f1efe2"
          >
            <template #full-width>
              <h3 class="numbers-tile__value">{{ evaluationsAnalytics.evaluations_number_this_year }}</h3>
              <h4 class="numbers-tile__subtitle">
                {{ $t('views.employees.overview.tiles.completed') }}
              </h4>
            </template>
          </numbers-tile>
        </v-flex>

        <v-flex xs12>
          <evaluations-past-year-chart-widget
            :chartData="evaluationsPastYearChartData"
            :loading="loading"
            color="secondary"
          />
        </v-flex>

        <v-flex xs12>
          <employees-by-users-chart-widget
            :chartData="employeesByUsersChartData"
            :loading="loading"
            color="secondary"
          />
        </v-flex>
      </v-layout>
    </v-flex>
  </v-layout>
</template>

<script>
import { mapState } from 'vuex'

import NumbersTile from '@components/shared/NumbersTile'

import PositionsChartWidget from '@components/employees/PositionsChartWidget'
import EmployeesPastYearChartWidget from '@components/employees/EmployeesPastYearChartWidget'
import EmployeesByUsersChartWidget from '@components/employees/EmployeesByUsersChartWidget'
import EvaluationsPastYearChartWidget from '@components/employees/EvaluationsPastYearChartWidget'

export default {
  name: 'EmployeesOverview',
  components: {
    NumbersTile,
    PositionsChartWidget,
    EmployeesPastYearChartWidget,
    EmployeesByUsersChartWidget,
    EvaluationsPastYearChartWidget
  },
  computed: {
    ...mapState('EmployeesOverviewModule', [
      'groups',
      'positionsChartData',
      'employeesPastYearChartData',
      'employeesAnalytics',
      'employeesByUsersChartData',
      'evaluationsPastYearChartData',
      'evaluationsAnalytics',
      'loading'
    ])
  },
  created() {
    this.$store.dispatch('EmployeesOverviewModule/fetchData')
  }
}
</script>
