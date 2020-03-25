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
      },
      task_sent_at: '',
      call_scheduled_at: '',
      interview_scheduled_at: '',
      decision_made_at: '',
      recruit_accepted_at: '',
      rejection_reason: ''
    };
  }

  get fullname() {
    return [this.first_name, this.last_name].join(' ')
  }

  get receivedAt() {
    return moment(this.received_at).format('YYYY-MM-DD HH:mm')
  }

  get taskSentAt() {
    if (!this.task_sent_at) return '---'

    return moment(this.task_sent_at).format('YYYY-MM-DD HH:mm')
  }

  get callScheduledAt() {
    if (!this.call_scheduled_at) return '---'

    return moment(this.call_scheduled_at).format('YYYY-MM-DD HH:mm')
  }

  get interviewScheduledAt() {
    if (!this.interview_scheduled_at) return '---'

    return moment(this.interview_scheduled_at).format('YYYY-MM-DD HH:mm')
  }

  get decisionMadeAt() {
    if (!this.decision_made_at) return '---'

    return moment(this.task_sent_at).format('YYYY-MM-DD HH:mm')
  }

  get recruitAcceptedAt() {
    if (!this.recruit_accepted_at) return '---'

    return moment(this.recruit_accepted_at).format('YYYY-MM-DD HH:mm')
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
