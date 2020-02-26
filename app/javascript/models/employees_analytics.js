import { Model } from './base'
import i18n from '@locales/i18n'

class EmployeesAnalytics extends Model {
  get defaults() {
    return {
      hired_employees_number: 0,
      archived_employees_number: 0,
      new_employees_number_this_year: 0,
      archived_employees_number_this_year: 0,
      average_employment_in_months: 0
    }
  }

  get averageEmployment() {
    return {
      months: this.average_employment_in_months % 12,
      years: Math.floor(this.average_employment_in_months / 12)
    }
  }
}

export { EmployeesAnalytics }
