import { Model, List } from './base'

import moment from 'moment'

class Evaluation extends Model {
  get defaults() {
    return {
      id: null,
      employee_id: null,
      first_name: '',
      last_name: '',
      position: '',
      hired_on: null,
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

  get fullname() {
    return [this.first_name, this.last_name].join(' ')
  }

  get hiredOn() {
    return moment(this.hired_on).format('MMMM YYYY')
  }

  get nextEvaluationOn() {
    if (!this.next_evaluation_on) return 'First time'

    return moment(this.next_evaluation_on).format('MMM YYYY')
  }

  get updatedAtFromNow() {
    return moment(this.updated_at).fromNow()
  }

  get draftPath() {
    return { name: 'evaluation_draft_path', params: { id: this.id } }
  }

  get completedPath() {
    return {
      name: 'evaluation_completed_path',
      params: {
        employeeId: this.employee_id,
        id: this.id
      }
    }
  }

  browserPath(employeeId) {
    return {
      name: 'evaluation_browser_path',
      params: {
        employeeId,
        id: this.id
      }
    }
  }

  static get routes() {
    return {
      evaluationEmployablesPath: '/v2/evaluation_employables',
      draftEvaluationEmployablePath: id => `/v2/evaluation_employables/${id}/draft`,
      completedEvaluationEmployablePath: id => `/v2/evaluation_employables/${id}/completed`,
      formEvaluationEmployablePath: '/v2/evaluation_employables/form',
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
