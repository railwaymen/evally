import { Model, List } from './base'

import moment from 'moment'

class PositionChange extends Model {
  get defaults() {
    return {
      id: null,
      previous_position: '',
      current_position: '',
      changed_on: null
    };
  }

  get changedOn() {
    return moment(this.changed_on).format('DD MMM YYYY')
  }
}

class PositionChangesList extends List {
  get model() {
    return PositionChange;
  }
}

export { PositionChange, PositionChangesList };
