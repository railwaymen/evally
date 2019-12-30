import { Model, List } from './base'

class Section extends Model {
  get defaults() {
    return {
      id: null,
      group: '',
      name: '',
      position: null,
      skills: []
    }
  }
}

class SectionsList extends List {
  get model() {
    return Section
  }
}

export { Section, SectionsList }
