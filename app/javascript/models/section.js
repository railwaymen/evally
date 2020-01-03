import { Model, List } from './base'

class Section extends Model {
  get defaults() {
    return {
      id: null,
      group: '',
      name: '',
      position: null,
      skills: []
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
}

class SectionsList extends List {
  get model() {
    return Section
  }
}

export { Section, SectionsList }
