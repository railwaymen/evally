<template>
  <div class="positions-chart">
    <horizontal-bar
      :dataset="dataset"
      :options="options"
    />

    <div class="text-xs-center mb-3">
      <v-chip
        v-for="(group, index) in groups"
        :key="index"
        @click="currentGroup = group"
        :color="currentGroup === group ? colors[index] : 'grey'"
        text-color="white"
      >
        {{ group }}
      </v-chip>
    </div>
  </div>
</template>

<script>
import HorizontalBar from '@components/charts/HorizontalBar'

import { colors } from '@utils/helpers'

export default {
  name: 'PositionsChart',
  components: { HorizontalBar },
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
    }
  },
  data() {
    return {
      colors,
      currentGroup: this.groups[0]
    }
  },
  computed: {
    filteredChartData() {
      return this.chartData.filter(item => item.group === this.currentGroup)
    },
    labels() {
      return this.filteredChartData.map(item => item.label)
    },
    values() {
      return this.filteredChartData.map(item => item.value)
    },
    dataset() {
      return {
        labels: this.labels,
        datasets: [
          {
            label: this.currentGroup,
            backgroundColor: this.colors[this.groups.indexOf(this.currentGroup)],
            data: this.values,
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
