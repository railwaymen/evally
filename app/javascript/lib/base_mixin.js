export default {
  methods: {
    flash (message) {
      this.$store.commit('FlashStore/push', message)
    },

    employeeFullname(employee) {
      return `${employee.first_name} ${employee.last_name}`
    },

    nextEvaluationDate(employee) {
			let date = employee.next_evaluation_at
			return date ? this.$moment(date).format('MMM YYYY') : 'First time'
		}
  }
}
