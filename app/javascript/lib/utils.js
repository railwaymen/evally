import _ from 'lodash'

let utils = {
  transformModel: model => {
    return _.merge({id: model.id}, model.attributes)
  },

  modelsFromResponse: data => {
    return _.map(data, this.a.transformModel)
  }
}

export { utils as Utils }
