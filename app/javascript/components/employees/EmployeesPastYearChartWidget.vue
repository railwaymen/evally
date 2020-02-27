<template>
  <div :class="['widget', `widget--border-${color}`]">
    <h3 class="widget__header">
      {{ $t('components.employees.employeesPastYearChart.title') }}
    </h3>

    <div class="widget__body">
      <div v-if="loading" class="widget__loader">
        <v-progress-circular :size="30" :width="3" color="color" indeterminate />
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
    },
    color: {
      type: String,
      required: false,
      default: 'primary'
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
            label: this.$t('components.employees.employeesPastYearChart.hiredEmployees'),
            data: this.hiredValues,
            backgroundColor: colors[10],
            categoryPercentage: 1.0,
            barPercentage: 0.9,
          },
          {
            label: this.$t('components.employees.employeesPastYearChart.archivedEmployees'),
            data: this.archivedValues,
            backgroundColor: colors[0],
            categoryPercentage: 1.0,
            barPercentage: 0.9,
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
              stepSize: 1,
              max: Math.ceil(Math.max(...this.hiredValues) * 1.1),
              min: Math.floor(Math.min(...this.archivedValues) * 1.1)
            }
          }]
        }
      }
    }
  }
}
</script>
