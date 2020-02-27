<template>
  <div class="widget widget--border-primary">
    <h3 class="widget__header">
      {{ $t('components.employees.employeesPartYearChart.title') }}
    </h3>

    <div class="widget__body">
      <div v-if="loading" class="widget__loader">
        <v-progress-circular :size="30" :width="3" color="primary" indeterminate />
      </div>

      <div v-else class="positions-chart">
        <bar-chart
          :dataset="dataset"
          :options="options"
        />
      </div>
    </div>
  </div>
</template>

<script>
import BarChart from '@components/charts/BarChart'

import { colors } from '@utils/helpers'

export default {
  name: 'EmployeesPastYearChartWidget',
  components: { BarChart },
  props: {
    chartData: {
      type: Array,
      required: true,
      default: () => []
    },
    loading: {
      type: Boolean,
      required: true,
      default: true
    }
  },
  computed: {
    labels() {
      return this.chartData.map(item => this.$moment(item.label).format('MMM YYYY'))
    },
    hiredValues() {
      return this.chartData.map(item => item.hired_value)
    },
    archivedValues() {
      return this.chartData.map(item => (-1 * item.archived_value))
    },
    dataset() {
      return {
        labels: this.labels,
        datasets: [
          {
            label: this.$t('components.employees.employeesPartYearChart.hiredEmployees'),
            data: this.hiredValues,
            backgroundColor: colors[28],
            categoryPercentage: 1.0,
            barPercentage: 0.8,
          },
          {
            label: this.$t('components.employees.employeesPartYearChart.archivedEmployees'),
            data: this.archivedValues,
            backgroundColor: colors[0],
            categoryPercentage: 1.0,
            barPercentage: 0.8,
          }
        ]
      }
    },
    options() {
      return {
        maintainAspectRatio: false,
        scales: {
          yAxes: [{
            ticks: {
              stepSize: 1
            }
          }]
        }
      }
    }
  }
}
</script>
