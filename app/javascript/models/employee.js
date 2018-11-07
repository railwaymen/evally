import { Model, Collection } from 'vue-mc'

// Validation rules
import { required, string } from 'vue-mc/validation'

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
      next_evaluation_at: null,
      public_token: null
    }
  }

  validation() {
    return {
      first_name: required.and(string).format("This field is required"),
      last_name: required.and(string).format("This field is required"),
      position: required.and(string).format("This field is required"),
      hired_at: required.and(string).format("This field is required")
    }
  }


  routes() {
    return {
      save: '/v1/employees',
      fetch: '/v1/employees/{id}',
      delete: '/v1/employees/{id}'
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
