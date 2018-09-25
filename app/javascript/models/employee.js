import { Model, Collection } from 'vue-mc'

/**
 * Employee model
 */
class Employee extends Model {

  // Default attributes that define the "empty" state.
  defaults() {
    return {
      id: null,
      first_name: '',
      last_name: '',
      position: '',
      hired_at: null,
      last_evaluation_at: null,
      next_evaluation_at: null
    }
  }
}

/**
 * Employees collection
 */
class EmployeesList extends Collection {

    // Model that is contained in this collection.
    model() {
      return Employee
    }

    // Route configuration
    routes() {
      return {
        fetch: '/v1/employees',
      }
    }
}

export { Employee, EmployeesList }
