export default {
  methods: {
    flash (message) {
      this.$store.commit('FlashStore/push', message)
    },

    employeeFullname(employee) {
      return [employee.first_name, employee.last_name].join(' ')
    },

    nextEvaluationDate(employee) {
			let date = employee.next_evaluation_at
			return date ? this.$moment(date).format('MMM YYYY') : 'First time'
    },

    renderError(errorResponse) {
      if (typeof errorResponse.data.data === 'object') {
        let details = errorResponse.data.data.attributes.details.join(', ')
        return details !== "" ? details : errorResponse.data.data.attributes.message
      } else {
        return errorResponse.statusText
      }
    }
  }
}
