export default {
  methods: {
    flash (message) {
      this.$store.commit('FlashStore/push', message)
    },

    employeeFullname(employee) {
      return `${employee.first_name} ${employee.last_name}`
    }
  }
}
