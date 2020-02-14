import { Model } from './base'

class EmployeesSearchQuery extends Model {
  get defaults() {
    return {
      group: 'rating',
      name: '',
      operator: 'eq',
      value: 0
    }
  }

  get isBool() {
    return this.group === 'bool'
  }

  get isRating() {
    return this.group === 'rating'
  }
}

export { EmployeesSearchQuery }
