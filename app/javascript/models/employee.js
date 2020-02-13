import { Model, List } from './base'
import i18n from '@locales/i18n'

import moment from 'moment'

class Employee extends Model {
  get defaults() {
    return {
      id: null,
      first_name: '',
      last_name: '',
      position: '',
      group: '',
      hired_on: null,
      position_set_at: null,
      next_evaluation_on: null,
      latest_evaluation_date: null,
      public_token: '',
      skill: {},
    };
  }

  get employmentTime() {
    const diff = moment().diff(this.hired_on, 'months')

    // fresh employee case
    if (diff === 0) return i18n.t('models.employee.justStarted')

    const months = diff % 12
    const years = Math.floor(diff / 12)
    const output = [i18n.t('models.employee.works')]

    // only months case
    if (years === 0 && months > 0) {
      return output.concat([i18n.tc('models.employee.month', months, { n: months })]).join(' ')
    }

    // full years case
    if (years > 0 && months === 0) {
      return output.concat([i18n.tc('models.employee.year', years, { n: years })]).join(' ')
    }

    return output.concat([
      i18n.tc('models.employee.year', years, { n: years }),
      i18n.t('models.employee.and'),
      i18n.tc('models.employee.month', months, { n: months })
    ]).join(' ')
  }

  get fullname() {
    return [this.first_name, this.last_name].join(' ')
  }

  get hiredOn() {
    return moment(this.hired_on).format('MMMM YYYY')
  }

  // === hired at datepicker getter & setter
  get hiredDate() {
    return this.hired_on ? moment(this.hired_on).format('YYYY-MM-DD') : ''
  }

  set hiredDate(date) {
    const mDate = moment(date, 'YYYY-MM-DD')
    this.hired_on = mDate.isValid() ? mDate.format() : ''
  }
  // ===

  get latestEvaluationDate() {
    if (!this.latest_evaluation_date) return '---'

    return moment(this.latest_evaluation_date).format('MMM DD, YYYY')
  }

  get nextEvaluationOn() {
    if (!this.next_evaluation_on) return i18n.t('models.employee.firstTime')

    return moment(this.next_evaluation_on).format('MMM YYYY')
  }

  // === next evaluation at datepicker getter & setter
  get nextEvaluationDate() {
    return this.next_evaluation_on ? moment(this.next_evaluation_on).format('YYYY-MM') : ''
  }

  set nextEvaluationDate(date) {
    const mDate = moment(date, 'YYYY-MM')
    this.next_evaluation_on = mDate.isValid() ? mDate.format() : ''
  }
  // ===

  get positionSetAt () {
    return moment(this.position_set_at).format('MMMM YYYY')
  }

  // === position set at datepicker getter & setter
  get positionSetDate() {
    return this.position_set_at ? moment(this.position_set_at).format('YYYY-MM-DD') : ''
  }

  set positionSetDate(date) {
    const mDate = moment(date, 'YYYY-MM-DD')
    this.position_set_at = mDate.isValid() ? mDate.format() : ''
  }
  // ===

  get publicLink() {
    return `${window.location.origin}/browse/${this.public_token}`
  }

  static get routes() {
    return {
      employeesPath: '/v2/employees',
      employeesOverviewPath: '/v2/employees/overview',
      employeesSearchPath: '/v2/employees/search',
      employeesSkillsPath: '/v2/employees/skills',
      employeePath: id => `/v2/employees/${id}`,
      browseEmployeePath: id => `/v2/browse/employees/${id}`
    }
  }
}

class EmployeesList extends List {
  get model() {
    return Employee;
  }
}

export { Employee, EmployeesList };
