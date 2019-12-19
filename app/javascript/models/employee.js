import { Model, List } from './base'

import moment from 'moment'

class Employee extends Model {
  get defaults() {
    return {
      id: null,
      first_name: '',
      last_name: '',
      position: '',
      group: '',
      hired_at: '',
      position_set_at: '',
      next_evaluation_at: '',
      latest_evaluation_date: ''
    };
  }

  get fullname() {
    return [this.first_name, this.last_name].join(' ')
  }

  get hiredAt () {
    return moment(this.hired_at).format('MMMM YYYY')
  }

  get latestEvaluationDate() {
    if (!this.latest_evaluation_date) return '---'

    return moment(this.latest_evaluation_date).format('MMM DD, YYYY')
  }

  get nextEvaluationAt() {
    if (!this.next_evaluation_at) return 'First time'

    return moment(this.next_evaluation_at).format('MMM YYYY')
  }

  static get routes() {
    return {
      employeesPath: 'v2/employees',
      employeePath: id => `v2/employees/${id}`
    }
  }
}

class EmployeesList extends List {
  get model() {
    return Employee;
  }
}

export { Employee, EmployeesList };
