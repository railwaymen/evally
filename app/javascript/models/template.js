import { Model, Collection } from 'vue-mc'

// Validation rules
import { required, string } from 'vue-mc/validation'


/**
 * Template model
 */
class Template extends Model {

  // Default attributes that define the "empty" state.
  defaults() {
    return {
      id: null,
      name: '',
      state: 'draft',
      evaluations_count: 0,
      sections: [],
      editable: false
    }
  }

  validation() {
    return {
      name: required.and(string).format("This field is required"),
    }
  }

}

/**
 * Templates collection
 */
class TemplatesList extends Collection {

    // Model that is contained in this collection.
    model() {
      return Template
    }

    routes() {
      return {
        fetch: '/v1/templates',
      }
    }
}

export { Template, TemplatesList }
