<template>
  <div class="box box--border-primary">
		<h3 class="box__header">Employees</h3>

    <div class="box__body">
      <highcharts class="chart" :options="chartOptions"></highcharts>
    </div>
  </div>
</template>

<script>
export default {
  name: 'EmployeesChart',
  data() {
    return {
      chartOptions: {
        chart: {
          type: 'column'
        },
        title: false,
        xAxis: {
          categories: [
            'Junior',
            'Regular',
            'Senior'
          ]
        },
        yAxis: {
          allowDecimals: false,
          title: {
            text: 'People'
          }
        },
        series: [
          {
            name: 'Ruby',
            data: [3, 6, 13]
          },
          {
            name: 'Java Script',
            data: [1, 5, 3]
          },
          {
            name: 'Android',
            data: [0, 1, 2]
          }
        ],
        plotOptions: {
          series: {
            events: {
              legendItemClick: (e) => {
                console.log('Click!')
              },
              hide: () => {
                console.log('Hide!')
              },
              show: () => {
                console.log('Show!')
              }
            }
          }
        }
      }
    }
  }
}
</script>