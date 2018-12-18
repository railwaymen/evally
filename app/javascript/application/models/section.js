import { Model, Collection } from 'vue-mc'

/**
 * Section model
 */
class Section extends Model {

  defaults() {
    return {
      id: null,
      name: '',
      group: '',
      width: '',
      position: null,
      skills: [],
      _destroy: 0
    }
  }
}

/**
 * Sections collection
 */
class SectionsList extends Collection {

  model() {
    return Section
  }
}

export { Section, SectionsList }
