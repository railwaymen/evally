import _ from 'lodash'

let utils = {
  transformModel(model) {
    return _.merge({id: model.id}, model.attributes)
  },

  modelsFromResponse(data) {
    return _.map(data, this.transformModel)
  },

  collectPositions(data) {
    return _.uniq(_.map(data, 'position'))
  },

  randomId(length) {
    return `id_${Math.random().toString(36).substring(length)}`
  },

  prepareSession(data) {
    return {
      user: _.pick(data.attributes, ['email', 'first_name', 'last_name']),
      setting: data.attributes.setting
    }
  }
}

export { utils as Utils }
