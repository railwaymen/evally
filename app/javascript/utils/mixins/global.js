export default {
  filters: {
    contentType2Icon(value) {
      switch(value) {
        case 'application/pdf':
          return 'mdi-file-pdf-outline'
        case 'application/zip':
          return 'mdi-archive-outline'
        case 'image/gif':
        case 'image/png':
        case 'image/jpeg':
          return 'mdi-file-image-outline'
        default:
          return 'mdi-file-outline'
      }
    }
  },
  methods: {
    flash (message) {
      this.$store.commit('NotificationsModule/PUSH_NOTIFICATION', message)
    },

    updateLocale(locale) {
      this.$i18n.locale = locale
      this.$vuetify.lang.current = locale
      this.$moment.locale(locale)
    },

    vMin6(val) {
      return !!val && val.length >= 6 || this.$t('shared.validations.min6')
    },

    vRequired(val) {
      return !!val || this.$t('shared.validations.required')
    }
  }
}
