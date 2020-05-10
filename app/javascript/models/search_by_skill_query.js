import { Model } from './base'

class SearchBySkillQuery extends Model {
  get defaults() {
    return {
      group: 'rating',
      name: '',
      operator: 'eq',
      value: 0
    }
  }

  get boolGroup() {
    return this.group === 'bool'
  }

  get ratingGroup() {
    return this.group === 'rating'
  }
}

export { SearchBySkillQuery }
