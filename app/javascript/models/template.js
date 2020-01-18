import { Model, List } from './base'

class Template extends Model {
  get defaults() {
    return {
      id: null,
      name: ''
    }
  }

  static get routes() {
    return {
      templatesPath: '/v2/templates'
    }
  }
}

class TemplatesList extends List {
  get model() {
    return Template
  }
}

export { Template, TemplatesList }
