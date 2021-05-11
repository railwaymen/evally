import { Model, List } from './base'

import moment from 'moment'

class Recruit extends Model {
  get defaults() {
    return {
      id: null,
      first_name: '',
      last_name: '',
      group: '',
      positions: '',
      source: '',
      received_at: '',
      evaluation_at: '',
      evaluator_fullname: '',
      accept_current_processing: false,
      accept_future_processing: false,
      public_recruit_id: '',
      skill: {
        group: '',
        name: '',
        value: 0
      },
      status: {
        value: '',
        label: '',
        color: ''
      }
    }
  }

  get recruitDocumentPath() {
    return {
      name: 'candidate_document_path',
      params: {
        publicRecruitId: this.public_recruit_id,
        id: this.id
      }
    }
  }

  get fullname() {
    return [this.first_name, this.last_name].join(' ')
  }

  get evaluationDate() {
    return moment(this.evaluation_date).format('DD MMM YYYY')
  }

  get receivedAt() {
    return moment(this.received_at).format('DD MMM YYYY, HH:mm')
  }

  static get routes() {
    return {
      recruitsSearchPath: '/v2/recruits/search',
      recruitsSkillsPath: '/v2/recruits/skills',
    }
  }
}

class RecruitsList extends List {
  get model() {
    return Recruit
  }
}

export { Recruit, RecruitsList }
