import { Model, List } from './base'

class Email extends Model {
  get defaults() {
    return {
      from: '',
      to: '',
      subject: '',
      body: '',
      public_recruit_id: null,
      recruit_document_id: null
    }
  }

  static get routes() {
    return {
      emailsPath: '/v2/emails',
      emailsFormPath: '/v2/emails/form'
    }
  }
}

class EmailsList extends List {
  get model() {
    return Email
  }
}

export { Email, EmailsList }
