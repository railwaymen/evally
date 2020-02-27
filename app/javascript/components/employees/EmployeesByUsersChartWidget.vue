<template>
  <div :class="['widget', `widget--border-${color}`]">
    <h3 class="widget__header">
      {{ $t('components.employees.employeesByUsersChart.title') }}
    </h3>

    <div class="widget__body">
      <div v-if="loading" class="widget__loader">
        <v-progress-circular :size="30" :width="3" :color="color" indeterminate />
      </div>

      <div v-else class="positions-chart">
        <horizontal-bar-chart
          :dataset="dataset"
          :options="options"
        />
      </div>
    </div>
  </div>
</template>

<script>
import HorizontalBarChart from '@components/charts/HorizontalBarChart'

import { colors } from '@utils/helpers'

export default {
  name: 'EmployeesByUsersChartWidget',
  components: { HorizontalBarChart },
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
      return this.chartData.map(item => item.label)
    },
    values() {
      return this.chartData.map(item => item.value)
    },
    dataset() {
      return {
        labels: this.labels,
        datasets: [
          {
            label: this.$t('components.employees.employeesByUsersChart.employees'),
            data: this.values,
            backgroundColor: colors[5],
            categoryPercentage: 1.0,
            barPercentage: 0.9,
          }
        ]
      }
    },
    options() {
      return {
        maintainAspectRatio: false,
        legend: {
          display: false
        },
        scales: {
          xAxes: [{
            ticks: {
              stepSize: 1,
              max: Math.ceil(Math.max(...this.values) * 1.1)
            }
          }]
        }
      }
    }
  }
}
</script>
