export default {
  methods: {
    employment(hired_at) {
      const diff = this.$moment().diff(hired_at, 'months')

      // fresh employee case
      if (diff === 0) return 'just started'

      const months = diff % 12
      const years = Math.floor(diff / 12)
      const result = [this.$t('widgets.employment.list_items.works')]

      // up to 1 year
      if (years === 0 && months > 0) return result.concat([months, this.$tc('widgets.employment.list_items.month', months)]).join(' ')

      // full years case
      if (years > 0 && months === 0) return result.concat([years, this.$tc('widgets.employment.list_items.year', years)]).join(' ')

      return result.concat(
        [
          years,
          this.$tc('widgets.employment.list_items.year', years),
          this.$t('widgets.employment.list_items.and'),
          months,
          this.$tc('widgets.employment.list_items.month', months)
        ]
      ).join(' ')
    }
  }
}