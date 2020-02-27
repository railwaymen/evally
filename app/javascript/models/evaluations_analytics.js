import { Model } from './base'

class EvaluationsAnalytics extends Model {
  get defaults() {
    return {
      average_evaluations: 0,
      total_evaluations_number: 0,
      evaluations_number_this_year: 0
    }
  }
}

export { EvaluationsAnalytics }
