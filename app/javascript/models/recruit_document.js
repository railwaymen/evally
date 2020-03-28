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
      task_sent_at: '',
      call_scheduled_at: '',
      interview_scheduled_at: '',
      decision_made_at: '',
      recruit_accepted_at: '',
      rejection_reason: '',
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
    return moment(this.received_at).format('YYYY-MM-DD HH:mm')
  }

  datetimeFormattedProperty(property) {
    if (!this[property]) return '---'

    return moment(this[property]).format('YYYY-MM-DD HH:mm')
  }

  static get routes() {
    return {
      recruitDocumentsPath: '/v2/recruit_documents',
      recruitDocumentsFilterPath: payload => `/v2/recruit_documents?${getURLParams(payload)}`,
      recruitDocumentsNewFormPath: '/v2/recruit_documents/new',
      recruitDocumentPath: id => `/v2/recruit_documents/${id}`,
      recruitPath: publicRecruitId => `/v2/recruits/${publicRecruitId}`,
      attachmentsPath: recruitDocumentId => `/v2/recruit_documents/${recruitDocumentId}/attachments`,
      attachmentPath: (recruitDocumentId, id) => `/v2/recruit_documents/${recruitDocumentId}/attachments/${id}`,
    }
  }
}

class RecruitDocumentsList extends List {
  get model() {
    return RecruitDocument;
  }
}

export { RecruitDocument, RecruitDocumentsList };
