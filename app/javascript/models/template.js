import { Model, List } from './base'

class Template extends Model {
  get defaults() {
    return {
      id: null,
      name: ''
    }
  }
}

class TemplatesList extends List {
  get model() {
    return Template
  }
}

export { Template, TemplatesList }
