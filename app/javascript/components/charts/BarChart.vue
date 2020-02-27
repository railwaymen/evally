<script>
import { Bar } from 'vue-chartjs'

export default {
  name: 'BarChart',
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
  watch: {
    dataset() {
      this.renderChart(this.dataset, this.options)
    }
  },
  mounted() {
    this.renderChart(this.dataset, this.options)
  }
}
</script>
