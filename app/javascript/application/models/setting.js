import { Model, Collection } from 'vue-mc'

/**
 * Setting model
 */
class Setting extends Model {

  defaults() {
    return {
      default_draft_items: 0,
      default_upcoming_items: 0,
      default_next_evaluation_time: 0,
      public_view_enabled: false
    }
  }
}

export { Setting }
