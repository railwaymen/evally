import { Model, List } from './base'

class Email extends Model {
  get defaults() {
    return {
      from: '',
      to: '',
      subject: '',
      body: '',
      signature: ''
    }
  }

  static get routes() {
    return {
      mailerPath: '/v2/emails/form'
    }
  }
}

class EmailsList extends List {
  get model() {
    return Email
  }
}

export { Email, EmailsList }
