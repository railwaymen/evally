import { Model, Collection } from 'vue-mc'

/**
 * Template model
 */
class Template extends Model {

  defaults() {
    return {
      id: null,
      name: '',
      state: 'draft',
      evaluations_count: 0,
      sections_attributes: [],
      editable: false
    }
  }

  routes() {
    return {
      save: '/v1/templates',
      fetch: '/v1/templates/{id}',
      delete: '/v1/templates/{id}'
    }
  }

}

/**
 * Templates collection
 */
class TemplatesList extends Collection {

  model() {
    return Template
  }

  routes() {
    return {
      fetch: '/v1/templates',
    }
  }
}

export { Template, TemplatesList }
