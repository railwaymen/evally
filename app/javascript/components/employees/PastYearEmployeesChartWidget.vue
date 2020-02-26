<template>
  <div class="widget widget--border-primary">
    <h3 class="widget__header">
      New Employees Over Past Year
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
  name: 'PositionsChartWidget',
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
  data() {
    return {
      colors
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
            data: this.values,
            backgroundCOlor: ['#f00', '#f0f'],
            categoryPercentage: 1.0,
            barPercentage: 0.8,
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
          yAxes: [{
            ticks: {
              beginAtZero: true,
              stepSize: 1,
              max: Math.ceil(Math.max(...this.values) * 1.2)
            }
          }]
        }
      }
    }
  }
}
</script>
