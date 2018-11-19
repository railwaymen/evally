import { Model, Collection } from 'vue-mc'

/**
 * Activity model
 */
class Activity extends Model {

  // Default attributes that define the "empty" state.
  defaults() {
    return {
      id: null,
      title: '',
      description: '',
      created_at: null
    }
  }
}

/**
 * Activities collection
 */
class ActivitiesList extends Collection {

    // Model that is contained in this collection.
    model() {
      return Activity
    }

    // Route configuration
    routes() {
      return {
        fetch: '/v1/activities',
      }
    }
}

export { Activity, ActivitiesList }
