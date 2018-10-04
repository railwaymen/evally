import { Model, Collection } from 'vue-mc'

// Validation rules
import { required, string } from 'vue-mc/validation'

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
      skills: []
    }
  }

}

export { Section }
