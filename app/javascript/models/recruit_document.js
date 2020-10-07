import { Model, List } from './base'
import { getURLParams, currentTimezone } from '@utils/helpers'

import moment from 'moment-timezone'

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
      received_at: '',
      accept_current_processing: false,
      accept_future_processing: false,
      public_recruit_id: '',
      incomplete_details: '',
      task_sent_at: '',
      call_scheduled_at: '',
      interview_scheduled_at: '',
      rejection_reason: '',
      evaluator_token: null,
      social_links: [],
      salary: '',
      availability: '',
      available_since: '',
      location: '',
      contract_type: '',
      work_type: '',
      message: '',
      status: {
        value: '',
        label: '',
        color: '',
        required_fields: []
      }
    };
  }

  get showPath() {
    return {
      name: 'recruitment_path',
      params: {
        publicRecruitId: this.public_recruit_id,
        id: this.id
      }
    }
  }

  get editPath() {
    return {
      name: 'edit_recruitment_path',
      params: {
        publicRecruitId: this.public_recruit_id,
        id: this.id
      }
    }
  }

  get mailerPath() {
    return {
      name: 'recruitment_mailer_path',
      params: {
        publicRecruitId: this.public_recruit_id,
        id: this.id
      }
    }
  }

  get availableSince() {
    if (!this.available_since) return ''

    return moment(this.available_since).format('DD MMM YYYY')
  }

  // === available datepicker getter & setter
  get availableSinceDate() {
    return this.available_since ? moment(this.available_since).format('YYYY-MM-DD') : ''
  }

  set availableSinceDate(date) {
    const mDate = moment(date, 'YYYY-MM-DD')
    this.available_since = mDate.isValid() ? mDate.format() : ''
  }
  // ===

  get fullname() {
    return [this.first_name, this.last_name].join(' ')
  }

  get labeledEmail() {
    return `${this.fullname} <${this.email}>`
  }

  get receivedAt() {
    return moment(this.received_at).tz(currentTimezone).format('DD MMM YYYY, HH:mm z')
  }

  datetimeFormattedProperty(property) {
    if (!this[property]) return '---'

    return moment(this[property]).tz(currentTimezone).format('DD MMM YYYY, HH:mm z')
  }

  static get routes() {
    return {
      recruitDocumentsPath: '/v2/recruit_documents',
      recruitDocumentsFilterPath: payload => `/v2/recruit_documents?${getURLParams(payload)}`,
      recruitDocumentsSearchPath: '/v2/recruit_documents/search',
      recruitDocumentsOverviewPath: '/v2/recruit_documents/overview',
      recruitDocumentPath: id => `/v2/recruit_documents/${id}`,
      formRecruitDocumentPath: '/v2/recruit_documents/form',
      recruitPath: publicRecruitId => `/v2/recruits/${publicRecruitId}`,
      mailerPath: recruitDocumentId => `/v2/recruit_documents/${recruitDocumentId}/mailer`,
      attachmentsPath: recruitDocumentId => `/v2/recruit_documents/${recruitDocumentId}/attachments`,
      attachmentPath: (recruitDocumentId, id) => `/v2/recruit_documents/${recruitDocumentId}/attachments/${id}`,
    }
  }

  static get placeholders() {
    return [
      {
        id: 'first_name',
        label: 'First Name'
      },
      {
        id: 'last_name',
        label: 'Last Name'
      },
      {
        id: 'email',
        label: 'Email'
      },
      {
        id: 'phone',
        label: 'Phone'
      },
      {
        id: 'position',
        label: 'Position'
      }
    ]
  }
}

class RecruitDocumentsList extends List {
  get model() {
    return RecruitDocument;
  }
}

export { RecruitDocument, RecruitDocumentsList };
