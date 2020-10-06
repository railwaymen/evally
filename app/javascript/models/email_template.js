import { Model, List } from './base'

class EmailTemplate extends Model {
  get defaults() {
    return {
      id: null,
      name: '',
      subject: '',
      body: '',
      editable: false,
      creator_id: null,
      creator_fullname: ''
    }
  }

  get path() {
    return { name: 'email_template_path', params: { id: this.id } }
  }

  static get routes() {
    return {
      templatesPath: '/v2/email_templates',
      templatePath: id => `/v2/email_templates/${id}`
    }
  }
}

class EmailTemplatesList extends List {
  get model() {
    return EmailTemplate
  }
}

export { EmailTemplate, EmailTemplatesList }
