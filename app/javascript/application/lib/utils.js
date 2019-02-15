import _ from 'lodash'

let utils = {
  chartColors: ['#2f7ed8', '#0d233a', '#8bbc21', '#910000', '#1aadce', '#492970', '#f28f43', '#77a1e5', '#c42525', '#a6c96a'],

  pluckAttribute(data, attribute) {
    return _.filter(_.uniq(_.map(data, attribute)), Boolean)
  },

  randomId(length) {
    return `id_${Math.random().toString(36).substring(length)}`
  },

  prepareSession(data) {
    return {
      user: _.pick(data, ['email', 'first_name', 'last_name']),
      setting: data.setting
    }
  }
}

export { utils as Utils }
