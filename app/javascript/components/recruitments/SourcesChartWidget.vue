<template>
  <div :class="['widget', `widget--border-${color}`]">
    <h3 class="widget__header">{{ $t('views.recruitments.overview.sourcesChartTitle') }}</h3>

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
  name: 'SourcesChartWidget',
  components: { BarChart },
  props: {
    interval: {
      type: String,
      required: true,
      default: 'day'
    },
    chartData: {
      type: Array,
      required: true,
      default: () => []
    },
    sources: {
      type: Array,
      required: true,
      default: () => []
    },
    loading: {
      type: Boolean,
      required: false,
      default: false
    },
    color: {
      type: String,
      required: false,
      default: 'primary'
    }
  },
  computed: {
    labels() {
      const labelFormat = { day: 'DD', month: 'MMM' }[this.interval]

      return [
        ...new Set(this.chartData.map(item => item.label))
        ].map(label => this.$moment(label).format(labelFormat))
    },
    dataset() {
      return {
        labels: this.labels,
        datasets: this.sources.map((source, index) => ({
          label: source,
          data: this.chartData.filter(item => item.source === source).map(item => item.value),
          backgroundColor: colors[colors.length - index - 1],
          categoryPercentage: 1.0,
          barPercentage: 0.9,
        }))
      }
    },
    options() {
      return {
        maintainAspectRatio: false,
        tooltips: {
          mode: 'index',
          intersect: false
        },
        scales: {
          xAxes: [{
            stacked: true
          }],
          yAxes: [{
            beginAtZero: true,
            stacked: true,
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
