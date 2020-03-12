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
      employee_hired_on: null,
      next_evaluation_on: null,
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

  get employeeHiredOn() {
    return moment(this.employee_hired_on).format('MMMM YYYY')
  }

  get nextEvaluationOn() {
    if (!this.next_evaluation_on) return 'First time'

    return moment(this.next_evaluation_on).format('MMM YYYY')
  }

  get updatedAtFromNow() {
    return moment(this.updated_at).fromNow()
  }

  get draftPath() {
    return { name: 'evaluation_path', params: { id: this.id } }
  }

  get path() {
    return {
      name: 'evaluation_path',
      params: {
        employeeId: this.employee_id,
        id: this.id
      }
    }
  }

  browsePath(employeeId) {
    return {
      name: 'evaluation_browse_path',
      params: {
        employeeId,
        id: this.id
      }
    }
  }

  static get routes() {
    return {
      draftsPath: '/v2/drafts',
      draftPath: id => `/v2/drafts/${id}`,
      evaluationPath: id => `/v2/evaluations/${id}`,
      browseEvaluationPath: (employeeId, id) => `/v2/browse/employees/${employeeId}/evaluations/${id}`
    }
  }
}

class EvaluationsList extends List {
  get model() {
    return Evaluation
  }
}

export { Evaluation, EvaluationsList }
