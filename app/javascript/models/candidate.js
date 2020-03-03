import { Model, List } from './base'
import i18n from '@locales/i18n'

class Candidate extends Model {
  get defaults() {
    return {
      id: null,
      first_name: '',
      last_name: '',
      email: '',
      gender: ''
    };
  }

  get fullname() {
    return [this.first_name, this.last_name].join(' ')
  }

  static get routes() {
    return {
      candidatesPath: '/v2/candidates',
      candidatePath: id => `/v2/candidates/${id}`
    }
  }
}

class CandidatesList extends List {
  get model() {
    return Candidates;
  }
}

export { Candidate, CandidatesList };
