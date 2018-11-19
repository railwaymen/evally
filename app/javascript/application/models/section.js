import { Model, Collection } from 'vue-mc'

// Validation rules
import { array, numeric, required, string, rule, messages } from 'vue-mc/validation'

const existsIn = (arr) => {
  return rule({
      name: 'existsIn',
      test: value => arr.indexOf(value) !== -1,
      data: { joined_arr: arr.join(' or ') }
  })
}
messages.set('existsIn', 'Must be included in ${joined_arr}');

/**
 * Section model
 */
class Section extends Model {

  // Default attributes that define the "empty" state.
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

  validation() {
    return {
      name: required.and(string).format("This field is required"),
      group: required.and(string).and(existsIn(['rating', 'bool', 'text'])),
      width: required.and(string).and(existsIn(['full', 'half'])),
      position: required.and(numeric),
      skills: required.and(array)
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
