import defaultsDeep from 'lodash/defaultsDeep'
import get from 'lodash/get'
import set from 'lodash/set'

export class Model {
  constructor(attributes = {}) {
    defaultsDeep(this, attributes, this.defaults)
  }

  assign(attributes) {
    return Object.assign(this, attributes);
  }

  get(attribute) {
    return get(this, attribute)
  }

  set(attribute, value) {
    set(this, attribute, value)
  }

  get isNew() {
    return [null, undefined, ''].includes(this.id)
  }

  get isPersisted() {
    return !this.isNew
  }
}

export class List {
  constructor(items = []) {
    this.models = items.map(item => new (this.model)(item));
  }

  get isEmpty() {
    return this.models.length === 0
  }

  findById(id) {
    return this.models.find(mod => Number(mod.id) === Number(id))
  }

  unshift(item) {
    this.models.unshift(new (this.model)(item))
  }

  push(item) {
    this.models.push(new (this.model)(item))
  }

  refresh(attributes) {
    this.models = this.models.map(mod => (
      Number(mod.id) === Number(attributes.id) ? mod.assign(attributes) : mod
    ))
  }

  dropById(id) {
    this.models = this.models.filter(mod => Number(mod.id) !== Number(id))
  }
}
