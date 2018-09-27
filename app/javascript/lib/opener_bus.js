import Vue from 'vue'

export default new Vue({
  methods: {
    openFormModal(options) {
      this.$emit('openFormModal', options)
    }
  }
})
