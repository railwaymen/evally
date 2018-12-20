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
      employee: null
    }
  }

  routes() {
    return {
      save: '/v1/evaluations',
      fetch: '/v1/evaluations/{id}',
      delete: '/v1/evaluations/{id}'
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
