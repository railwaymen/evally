<script>
import { Bar } from 'vue-chartjs'

import ChartJsPluginDataLabels from 'chartjs-plugin-datalabels'

export default {
  name: 'BarChart',
  components: { ChartJsPluginDataLabels },
  extends: Bar,
  props: {
    dataset: {
      type: Object,
      required: true,
      default: null
    },
    options: {
      type: Object,
      required: true,
      default: null
    }
  },
  computed: {
    extendedOptions() {
      return {
        plugins: {
          datalabels: {
            color: '#fff',
            display: context => context.dataset.data[context.dataIndex] !== 0,
            font: {
              weight: 'bold'
            }
          }
        },
        ...this.options
      }
    }
  },
  watch: {
    dataset() {
      this.renderChart(this.dataset, this.extendedOptions)
    }
  },
  mounted() {
    this.renderChart(this.dataset, this.extendedOptions)
  }
}
</script>
