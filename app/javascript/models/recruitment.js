import { Model, List } from './base'
import moment from 'moment'

class Recruitment extends Model {
  get defaults() {
    return {
      id: null,
      candidate_id: null,
      gender: '',
      first_name: '',
      last_name: '',
      email: '',
      status: '',
      group: '',
      phone: '',
      position: '',
      received_at: '',
      social_links: '',
      source: ''
    };
  }

  get fullname() {
    return [this.first_name, this.last_name].join(' ')
  }

  get receivedOn() {
    return moment(this.received_at).format('MMM DD, YYYY')
  }

  static get routes() {
    return {
      recruitmentsPath: '/v2/recruitments',
      recruitmentPath: id => `/v2/recruitments/${id}`
    }
  }
}

class RecruitmentsList extends List {
  get model() {
    return Recruitment;
  }
}

export { Recruitment, RecruitmentsList };
