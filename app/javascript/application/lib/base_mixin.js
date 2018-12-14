export default {
  methods: {
    flash (message) {
      this.$store.commit('FlashStore/push', message)
    },

    fullname(employee) {
      return [employee.first_name, employee.last_name].join(' ').trim()
    },

    nextEvaluationDate(employee) {
			let date = employee.next_evaluation_at
			return date ? this.$moment(date).format('MMM YYYY') : this.$t('dashboard.common.first_time')
    },

    renderError(errorResponse) {
      if (typeof errorResponse.data.data === 'object') {
        let details = errorResponse.data.data.attributes.details.join(', ')
        return details !== "" ? details : errorResponse.data.data.attributes.message
      } else {
        return errorResponse.statusText
      }
    },

    updateLocale(locale) {
      this.$i18n.locale = locale
      this.$moment.locale(locale)
    }
  },
  computed: {

    isLoading() {
			return this.status === 'loading'
    }
  }
}
