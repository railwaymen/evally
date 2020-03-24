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
      group: '',
      phone: '',
      position: '',
      source: '',
      received_at: moment().format('YYYY-MM-DD'),
      accept_current_processing: false,
      accept_future_processing: false,
      public_recruit_id: '',
      status: {
        value: '',
        label: '',
        color: '',
        required_fields: []
      }
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
      recruitDocumentsFormPath: '/v2/recruit_documents/form',
      recruitDocumentPath: id => `/v2/recruit_documents/${id}`,
      recruitPath: publicRecruitId => `/v2/recruits/${publicRecruitId}`
    }
  }
}

class RecruitDocumentsList extends List {
  get model() {
    return RecruitDocument;
  }
}

export { RecruitDocument, RecruitDocumentsList };
