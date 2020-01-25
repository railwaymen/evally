<script>
import { HorizontalBar } from 'vue-chartjs'

export default {
  name: 'GroupsChart',
  extends: HorizontalBar,
  data() {
    return {
      chartdata: {
        labels: ['Junior Dev', 'Regular Dev', 'Senior Dev'],
        datasets: [
          {
            label: 'Programmers',
            backgroundColor: '#f87979',
            maxBarThickness: 48,
            data: [10, 15, 5]
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          xAxes: [{
            ticks: {
              beginAtZero: true
            }
          }]
        }
      }
    }
  },
  mounted () {
    this.renderChart(this.chartdata, this.options)
  }
}
</script>
