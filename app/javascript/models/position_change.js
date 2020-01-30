import { Model, List } from './base'

import moment from 'moment'

class PositionChange extends Model {
  get defaults() {
    return {
      id: null,
      previous_position: '',
      current_position: '',
      changed_at: null
    };
  }

  get changedAt() {
    return moment(this.changed_at).format('MMM DD, YYYY')
  }
}

class PositionChangesList extends List {
  get model() {
    return PositionChange;
  }
}

export { PositionChange, PositionChangesList };
