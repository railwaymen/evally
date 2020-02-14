import defaultsDeep from 'lodash/defaultsDeep'
import get from 'lodash/get'
import set from 'lodash/set'

class Model {
  constructor(attributes = {}) {
    defaultsDeep(this, attributes, { ...this.defaults })
    this.errors = {}
  }

  get attributes() {
    const { id, errors, ...attrs } = this
    return attrs
  }

  get isNewRecord() {
    return this.id === null || this.id === undefined
  }

  get isPersisted() {
    return !this.isNewRecord
  }

  assign(properties) {
    return Object.assign(this, properties)
  }

  get(property) {
    get(this, property)
  }

  set(property, value) {
    set(this, property, value)
  }
}

class List {
  constructor(items = []) {
    this.models = items.map(item => new (this.model)(item));
  }

  get isEmpty() {
    return this.models.length === 0
  }

  findById(id) {
    return this.models.find(model => Number(model.id) === Number(id))
  }

  add(attributes) {
    this.models.unshift(new (this.model)(attributes))
  }

  refresh(attributes) {
    this.models = this.models.map(model => (
      Number(model.id) === Number(attributes.id) ? model.assign(attributes) : model
    ))
  }

  replace(item) {
    this.models = this.models.map(model => Number(model.id) === Number(item.id) ? item : model)
  }

  remove(id) {
    this.models = this.models.filter(model => Number(model.id) !== Number(id))
  }
}

export { Model, List };
