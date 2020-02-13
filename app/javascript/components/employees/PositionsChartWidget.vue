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
        <horizontal-bar
          :dataset="dataset"
          :options="options"
        />

        <div class="text-center mb-3">
          <v-chip
            v-for="(group, index) in groups"
            :key="index"
            @click="currentGroup = group"
            :color="currentGroup === group ? colors[index] : 'grey'"
            text-color="white"
            class="mx-1"
          >
            {{ group }}
          </v-chip>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import HorizontalBar from '@components/charts/HorizontalBar'

import { colors } from '@utils/helpers'

export default {
  name: 'PositionsChartWidget',
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
    },
    loading: {
      type: Boolean,
      required: true,
      default: true
    }
  },
  data() {
    return {
      colors,
      currentGroup: null
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
  },
  watch: {
    groups(newVal) {
      this.currentGroup = newVal[0]
    }
  }
}
</script>
