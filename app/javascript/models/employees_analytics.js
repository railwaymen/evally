import { Model } from './base'
import i18n from '@locales/i18n'

class EmployeesAnalytics extends Model {
  get defaults() {
    return {
      average_employment: 0
    }
  }

  get averageEmployment() {
    const months = this.average_employment % 12
    const years = Math.floor(this.average_employment / 12)

    // only months case
    if (years === 0 && months >= 0) {
      return [i18n.tc('models.employeesAnalytics.month', months, { n: months })].join(' ')
    }

    // full years case
    if (years > 0 && months === 0) {
      return [i18n.tc('models.employeesAnalytics.year', years, { n: years })].join(' ')
    }

    return [
      i18n.tc('models.employeesAnalytics.year', years, { n: years }),
      i18n.t('models.employeesAnalytics.and'),
      i18n.tc('models.employeesAnalytics.month', months, { n: months })
    ].join(' ')
  }
}

export { EmployeesAnalytics }
