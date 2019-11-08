import { Model, Collection } from 'vue-mc'

/**
 * Employee model
 */
class Employee extends Model {

  defaults() {
    return {
      id: null,
      first_name: '',
      last_name: '',
      position: '',
      group: 'Unassigned',
      hired_at: null,
      next_evaluation_at: null,
      public_token: null,
      state: 'hired',
      released_at: null,
      position_set_at: null,
      evaluation: {},
      position_changes: [],
    }
  }

  fullname() {
    return [this.first_name, this.last_name].join(' ').trim()
  }

  haveEvaluation() {
    return !!this.evaluation.id
  }

  isExperienced() {
    return this.state === 'experienced'
  }

  isHired() {
    return this.state === 'hired'
  }

  isReleased() {
    return this.state === 'released'
  }

  withoutEvaluation() {
    return _.omit(this.attributes, 'evaluation')
  }

  routes() {
    return {
      fetch: '/v1/employees/{id}'
    }
  }
}

/**
 * Employees collection
 */
class EmployeesList extends Collection {

  model() {
    return Employee
  }

  routes() {
    return {
      fetch: '/v1/employees',
    }
  }
}

export { Employee, EmployeesList }
