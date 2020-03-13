import { Model, List } from './base'
import { getURLParams } from '@utils/helpers'

import moment from 'moment'

class RecruitDocument extends Model {
  get defaults() {
    return {
      id: null,
      gender: '',
      first_name: '',
      last_name: '',
      email: '',
      status: '',
      group: '',
      phone: '',
      position: '',
      received_at: moment().format('YYYY-MM-DD'),
      accept_current_process: '',
      accept_future_processes: '',
      source: ''
    };
  }

  get fullname() {
    return [this.first_name, this.last_name].join(' ')
  }

  get receivedAt() {
    return moment(this.received_at).format('MMM DD, YYYY HH:mm')
  }

  static get routes() {
    return {
      recruitDocumentsPath: '/v2/recruit_documents',
      recruitDocumentsFilterPath: payload => `/v2/recruit_documents?${getURLParams(payload)}`,
      recruitDocumentPath: id => `/v2/recruit_documents/${id}`,
      newRecruitDocumentsPath: '/v2/recruit_documents/new',
    }
  }
}

class RecruitDocumentsList extends List {
  get model() {
    return RecruitDocument;
  }
}

export { RecruitDocument, RecruitDocumentsList };
