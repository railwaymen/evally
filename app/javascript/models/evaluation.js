import { Model, List } from './base'

import moment from 'moment'

class Evaluation extends Model {
  get defaults() {
    return {
      id: null,
      employee_id: null,
      employee_first_name: '',
      employee_last_name: '',
      employee_position: '',
      employee_hired_at: null,
      next_evaluation_at: null,
      completed_at: '',
      state: '',
      template_name: '',
      updated_at: null
    }
  }

  get completedAt() {
    return moment(this.completed_at).format('MMM DD, YYYY')
  }

  get employeeFullname() {
    return [this.employee_first_name, this.employee_last_name].join(' ')
  }

  get employeeHiredAt() {
    return moment(this.employee_hired_at).format('MMMM YYYY')
  }

  get nextEvaluationAt() {
    if (!this.next_evaluation_at) return 'First time'

    return moment(this.next_evaluation_at).format('MMM YYYY')
  }

  get updatedAtFromNow() {
    return moment(this.updated_at).fromNow()
  }

  get path() {
    return { name: 'evaluation_path', params: { id: this.id } }
  }

  static get routes() {
    return {
      draftsPath: '/v2/drafts',
      draftPath: id => `/v2/drafts/${id}`
    }
  }
}

class EvaluationsList extends List {
  get model() {
    return Evaluation
  }
}

export { Evaluation, EvaluationsList }
