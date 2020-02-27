<template>
  <div class="widget widget--border-primary">
    <h3 class="widget__header">
      {{ $t('components.employees.positionsChart.title') }}
    </h3>

    <div class="widget__body">
      <div v-if="loading" class="widget__loader">
        <v-progress-circular :size="30" :width="3" color="primary" indeterminate />
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
  name: 'PositionsChartWidget',
  components: { HorizontalBarChart },
  props: {
    chartData: {
      type: Array,
      required: true,
      default: () => []
    },
    groups: {
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
      group: null
    }
  },
  computed: {
    dataset() {
      return {
        labels: this.chartData.filter(item => item.group === this.group).map(item => item.label),
        datasets: this.groups.map((group, index) => ({
          label: group,
          data: this.chartData.filter(item => item.group === group).map(item => item.value),
          backgroundColor: this.group === group ? colors[index] : 'gray',
          hidden: this.group !== group,
          categoryPercentage: 1.0,
          barPercentage: 0.8
        }))
      }
    },
    options() {
      return {
        maintainAspectRatio: false,
        legend: {
          onClick: (_e, legendItem) => {
            this.group = legendItem.text
          }
        },
        scales: {
          xAxes: [{
            ticks: {
              beginAtZero: true,
              stepSize: 1
            }
          }]
        }
      }
    }
  },
  watch: {
    groups(newVal) {
      this.group = newVal[0]
    }
  }
}
</script>
