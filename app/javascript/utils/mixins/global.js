export default {
  methods: {
    flash (message) {
      this.$store.commit('FlashStore/push', message)
    },

    fetchError(error) {
      if (typeof error.data === 'object') {
        const details = error.data.details.join(', ')

        return details !== '' ? details : error.data.message
      } else {
        return error.statusText
      }
    },

    updateLocale(locale) {
      this.$i18n.locale = locale
      this.$vuetify.lang.current = locale
      this.$moment.locale(locale)
    },

    vIsString(val) {
      return this.$_.isString(val) || this.$t('shared.validations.isString')
    },

    vMin6(val) {
      return !!val && val.length >= 6 || this.$t('shared.validations.min6')
    },

    vRequired(val) {
      return !!val || this.$t('shared.validations.required')
    }
  }
}
