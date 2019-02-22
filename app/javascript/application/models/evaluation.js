import { Model, Collection } from 'vue-mc'

/**
 * Evaluation model
 */
class Evaluation extends Model {

  defaults() {
    return {
      id: null,
      state: 'draft',
      completed_at: null,
      template_name: '',
      sections_attributes: [],
      employee: {}
    }
  }

  employeeName() {
    return [this.employee.first_name, this.employee.last_name].join(' ').trim()
  }

  isCompleted() {
    return !!this.completed_at && this.state === 'completed'
  }

  isDraft() {
    return !this.completed_at && this.state === 'draft'
  }

  withoutEmployee() {
    return _.omit(this.attributes, 'employee')
  }

  routes() {
    return {
      fetch: '/v1/evaluations/{id}'
    }
  }
}

/**
 * Evaluations collection
 */
class EvaluationsList extends Collection {

  model() {
    return Evaluation
  }

  routes() {
    return {
      fetch: '/v1/evaluations'
    }
  }

}

export { Evaluation, EvaluationsList }
