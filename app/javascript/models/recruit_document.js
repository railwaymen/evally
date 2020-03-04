import { Model, List } from './base'
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
      received_at: '',
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
      recruitDocumentsPath: (group, status) => `/v2/recruit_documents?group=${group}&status=${status}`,
      recruitDocumentPath: id => `/v2/recruit_documents/${id}`
    }
  }
}

class RecruitDocumentsList extends List {
  get model() {
    return RecruitDocument;
  }
}

export { RecruitDocument, RecruitDocumentsList };
