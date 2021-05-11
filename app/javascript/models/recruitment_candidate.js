import { Model, List } from './base'
import { currentTimezone } from '@utils/helpers'

import moment from 'moment-timezone'

class RecruitmentCandidate extends Model {
  get defaults() {
    return {
      id: null,
      first_name: '',
      last_name: '',
      position: '',
      received_at: null,
      public_recruit_id: null,
      recruit_document_id: null,
      evaluator_token: null,
      status: {
        value: '',
        label: '',
        color: '',
        required_fields: []
      }
    }
  }

  get showPath() {
    return {
      name: 'candidate_document_path',
      params: {
        publicRecruitId: this.public_recruit_id,
        id: this.recruit_document_id
      }
    }
  }

  get fullname() {
    return [this.first_name, this.last_name].join(' ')
  }

  get receivedAt() {
    return moment(this.received_at).tz(currentTimezone).format('DD MMM YYYY')
  }

  static get routes() {
    return {
      candidatePath: id => `/v2/recruitment_candidates/${id}`,
      moveCandidatePath: id => `/v2/recruitment_candidates/${id}/move`
    }
  }
}

class RecruitmentCandidatesList extends List {
  get model() {
    return RecruitmentCandidate
  }
}

export { RecruitmentCandidate, RecruitmentCandidatesList }
