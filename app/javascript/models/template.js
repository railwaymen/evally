import { Model, List } from './base'

class Template extends Model {
  get defaults() {
    return {
      id: null,
      name: '',
      destination: '',
      editable: false,
      creator_id: null,
      creator_fullname: ''
    }
  }

  get destinationColor() {
    const colors = {
      employees: 'secondary',
      recruits: 'accent'
    }

    return this.destination ? colors[this.destination] : 'primary'
  }

  get destinationLetter() {
    const letters = {
      employees: 'E',
      recruits: 'R'
    }

    return this.destination ? letters[this.destination] : ''
  }

  get isForEmployees() {
    return this.destination === 'employees'
  }

  get isForRecruits() {
    return this.destination === 'recruits'
  }

  get path() {
    return { name: 'evaluation_template_path', params: { id: this.id } }
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
