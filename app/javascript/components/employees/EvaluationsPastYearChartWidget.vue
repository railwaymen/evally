<template>
  <div :class="['widget', `widget--border-${color}`]">
    <h3 class="widget__header">
      {{ $t('components.employees.evaluationsPastYearChart.title') }}
    </h3>

    <div class="widget__body">
      <div v-if="loading" class="widget__loader">
        <v-progress-circular :size="30" :width="3" :color="color" indeterminate />
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
  name: 'EvaluationsPastYearChartWidget',
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
    values() {
      return this.chartData.map(item => item.value)
    },
    dataset() {
      return {
        labels: this.labels,
        datasets: [
          {
            label: this.$t('components.employees.evaluationsPastYearChart.completedEvaluations'),
            data: this.values,
            backgroundColor: colors[6],
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
          yAxes: [{
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
