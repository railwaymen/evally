import { Model, Collection } from 'vue-mc'

/**
 * Activity model
 */
class Activity extends Model {

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

  model() {
    return Activity
  }

  routes() {
    return {
      fetch: '/v1/activities',
    }
  }
}

export { Activity, ActivitiesList }
