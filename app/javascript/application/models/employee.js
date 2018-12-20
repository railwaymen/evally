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
      hired_at: null,
      next_evaluation_at: null,
      public_token: null,
      state: 'hired',
      released_at: null
    }
  }

  routes() {
    return {
      save: '/v1/employees',
      fetch: '/v1/employees/{id}',
      delete: '/v1/employees/{id}'
    }
  }

  fullname() {
    return [this.first_name, this.last_name].join(' ').trim()
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
