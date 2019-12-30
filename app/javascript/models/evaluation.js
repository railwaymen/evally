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
      employee_hired_at: '',
      next_evaluation_at: '',
      state: '',
      template_name: '',
      updated_at: ''
    }
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
      draftsEvaluations: '/v2/evaluations/drafts',
      evaluationPath: id => `/v2/evaluations/${id}`
    }
  }
}

class EvaluationsList extends List {
  get model() {
    return Evaluation
  }
}

export { Evaluation, EvaluationsList }
