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

  get employmentTime() {
    const diff = moment().diff(this.hired_at, 'months')

    // fresh employee case
    if (diff === 0) return 'just started'

    const months = diff % 12
    const years = Math.floor(diff / 12)
    const output = ['works']

    // up to 1 year
    if (years === 0 && months > 0) return output.concat([months, 'months']).join(' ')

    // full years case
    if (years > 0 && months === 0) return output.concat([years, 'years']).join(' ')

    return output.concat([years, 'years', 'and', months, 'months']).join(' ')
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

  get positionSetAt () {
    return moment(this.position_set_at).format('MMMM YYYY')
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
