export default {
  methods: {
    flash (message) {
      this.$store.commit('FlashStore/push', message)
    }
  }
}
