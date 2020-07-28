import { Model, List } from './base'
import { currentTimezone } from '@utils/helpers'

import moment from 'moment-timezone'

class InboundEmail extends Model {
  get defaults() {
    return {
      id: '',
      message_id: '',
      source: '',
      subject: '',
      created_at: '',
      status: '',
      parsed: false
    }
  }

  get createdAt() {
    return moment(this.created_at).tz(currentTimezone).format('DD MMM YYYY, HH:mm z')
  }

  static get routes() {
    return {
      inboundEmailsPath: '/v2/inbound_emails'
    }
  }
}

class InboundEmailsList extends List {
  get model() {
    return InboundEmail
  }
}

export { InboundEmail, InboundEmailsList }
