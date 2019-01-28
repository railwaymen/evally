import _ from 'lodash'

let utils = {
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
