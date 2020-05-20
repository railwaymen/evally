<script>
import { HorizontalBar } from 'vue-chartjs'

import ChartJsPluginDataLabels from 'chartjs-plugin-datalabels'

export default {
  name: 'HorizontalBarChart',
  components: { ChartJsPluginDataLabels },
  extends: HorizontalBar,
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
