import { Model, List } from './base'

class Template extends Model {
  get defaults() {
    return {
      id: null,
      name: '',
      editable: false,
      creator_id: null,
      creator_fullname: ''
    }
  }

  get path() {
    return { name: 'template_path', params: { id: this.id } }
  }

  static get routes() {
    return {
      templatesPath: '/v2/templates',
      templatePath: id => `/v2/templates/${id}`
    }
  }
}

class TemplatesList extends List {
  get model() {
    return Template
  }
}

export { Template, TemplatesList }
