<template>
  <div class="box box--border-primary">
		<h3 class="box__header">{{ $t('widgets.employees_chart.title') }}</h3>

    <div class="box__body">
      <div v-if="isDataEmpty" class="box__loader">
        <v-progress-circular :size="30" :width="3" color="primary" indeterminate></v-progress-circular>
      </div>

      <highcharts v-else class="chart" :options="chartOptions" ref="employeesChart"></highcharts>

      <div class="text-xs-center">
        <v-chip
          v-for="(group, index) in orderedGroups"
          :key="index"
          @click="changeGroup(group)"
          :color="isGroupSelected(group) ? colors[index] : 'grey'"
          text-color="white"
        >{{ group }}</v-chip>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

import { Utils } from '@/lib/utils'

export default {
  name: 'EmployeesChart',
  data() {
    return {
      data: {},
      currentGroup: null,
      colors: Utils.chartColors
    }
  },
  methods: {
    changeGroup(group) {
      this.currentGroup = group
    },

    isGroupSelected(group) {
      return this.currentGroup === group
    }
  },
  computed: {
    ...mapGetters({
      groups: 'EmployeesStore/groups'
    }),

    orderedGroups() {
      return this.groups.sort((a, b) => {
        return a.localeCompare(b)
      })
    },

    isDataEmpty() {
      return this.$_.isEmpty(this.data)
    },

    chartOptions() {
      return {
        chart: {
          type: 'bar'
        },
        title: false,
        xAxis: {
          type: 'category',
          labels: {
            style: {
              fontSize: '1.4rem',
              fontFamily: 'Muli, sans-serif'
            }
          }
        },
        yAxis: {
          allowDecimals: false,
          min: 0,
          title: {
            text: this.$t('widgets.employees_chart.x_axis_label'),
            style: {
              fontSize: '1.4rem',
              fontFamily: 'Muli, sans-serif'
            }
          },
          labels: {
            style: {
              fontSize: '1.4rem',
              fontFamily: 'Muli, sans-serif'
            }
          }
        },
        legend: {
          enabled: false
        },
        series: [{
          name: this.$t('widgets.employees_chart.title'),
          data: this.data[this.currentGroup],
          maxPointWidth: 50
        }]
      }
    }
  },
  watch: {
    currentGroup() {
      let barChart = this.$refs.employeesChart

      if (this.currentGroup && barChart) {
        let groupIndex = this.orderedGroups.indexOf(this.currentGroup)
        barChart.chart.series[0].update({ color: this.colors[groupIndex] })
      }
    }
  },
  created() {
    this.$http.get('v1/employees/chart')
      .then(response => {
        this.currentGroup = Object.keys(response.data)[0]
        this.data = response.data
      })
      .catch(error => {
        this.flash({ error: 'Charts data cannot be loaded due to some error.' })
      })
  }
}
</script>