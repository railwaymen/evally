import { Model, List } from './base'

class Section extends Model {
  get defaults() {
    return {
      id: null,
      group: '',
      name: '',
      position: null,
      skills: [],
      sensitive: false,
      _destroy: 0,
      temp_id: Math.random().toString(36).slice(-5),
    }
  }

  get isHalf() {
    return this.width === 'half'
  }

  get isFull() {
    return this.width === 'full'
  }

  get isRating() {
    return this.group === 'rating'
  }

  get isBool() {
    return this.group === 'bool'
  }

  get isText() {
    return this.group === 'text'
  }

  get groupData() {
    switch (this.group) {
      case 'rating':
        return {
          name: 'rating',
          defaultValue: 0,
          icon: 'mdi-star'
        }
      case 'bool':
        return {
          name: 'bool',
          defaultValue: false,
          icon: 'mdi-plus-minus'
        }
      case 'text':
        return {
          name: 'text',
          defaultValue: '',
          icon: 'mdi-text'
        }
      default:
        return {
          name: null,
          defaultValue: null,
          icon: null
        }
    }
  }
}

class SectionsList extends List {
  get model() {
    return Section
  }
}

export { Section, SectionsList }
