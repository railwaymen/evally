import { Model, List } from './base'

import moment from 'moment'

class Recruitment extends Model {
  get defaults() {
    return {
      id: null,
      name: '',
      description: '',
      status: 'draft',
      stages: [],
      started_at: null,
      completed_at: null,
      user_tokens: []
    }
  }

  get startedOn() {
    if (!this.started_at) return ''

    return moment(this.started_at).format('DD MMM YYYY')
  }

  get completedOn() {
    if (!this.completed_at) return ''

    return moment(this.completed_at).format('DD MMM YYYY')
  }

  get isDraft() {
    return this.status === 'draft'
  }

  get isStarted() {
    return this.status === 'started'
  }

  get isCompleted() {
    return this.status === 'completed'
  }

  static get routes() {
    return {
      recruitmentsPath: '/v2/recruitments',
      recruitmentPath: id => `/v2/recruitments/${id}`,
      startRecruitmentPath: id => `/v2/recruitments/${id}/start`,
      completeRecruitmentPath: id => `/v2/recruitments/${id}/complete`,
      addRecruitmentStagePath: id => `/v2/recruitments/${id}/add_stage`,
      dropRecruitmentStagePath: id => `/v2/recruitments/${id}/drop_stage`
    }
  }
}

class RecruitmentsList extends List {
  get model() {
    return Recruitment
  }
}

export { Recruitment, RecruitmentsList }
