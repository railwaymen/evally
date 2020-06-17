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
    if (!this.completed_at || this.isDraft) return 'Ongoing'

    return moment(this.completed_at).format('DD MMM YYYY')
  }

  get editable() {
    return this.isPersisted && this.isDraft
  }

  get fullname() {
    return [this.first_name, this.last_name].join(' ')
  }

  get hiredOn() {
    return moment(this.hired_on).format('DD MMM YYYY')
  }

  get isDraft() {
    return this.state === 'draft'
  }

  get nextEvaluationOn() {
    if (!this.next_evaluation_on) return 'First time'

    return moment(this.next_evaluation_on).format('MMM YYYY')
  }

  get recruitableSelectOption() {
    return `${this.position} (${this.template_name}) - ${this.completedAt}`
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
      evaluationEmployablesPath: '/v2/evaluation_employables',
      evaluationEmployablePath: id => `/v2/evaluation_employables/${id}`,
      draftEvaluationEmployablePath: id => `/v2/evaluation_employables/${id}/draft`,
      completedEvaluationEmployablePath: (employeeId, id) => `/v2/employees/${employeeId}/evaluations/${id}`,
      evaluationEmployableFormPath: '/v2/evaluation_employables/form',
      evaluationRecruitablesPath: '/v2/evaluation_recruitables',
      evaluationRecruitablePath: id => `/v2/evaluation_recruitables/${id}`,
      showEvaluationRecruitablePath: (recruitId, id) => `/v2/recruits/${recruitId}/evaluations/${id}`,
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
