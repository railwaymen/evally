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
      sections_attributes: [],
      editable: false
    }
  }

  isCreated() {
    return this.state === 'created'
  }

  isDraft() {
    return this.state === 'draft'
  }

  isVisible() {
    return (this.editable && this.isDraft()) || this.isCreated()
  }

  routes() {
    return {
      fetch: '/v1/templates/{id}'
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
