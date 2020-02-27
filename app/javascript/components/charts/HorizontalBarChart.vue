<script>
import { HorizontalBar } from 'vue-chartjs'

export default {
  name: 'HorizontalBarChart',
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
