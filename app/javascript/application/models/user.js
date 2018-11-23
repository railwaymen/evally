import { Model, Collection } from 'vue-mc'


/**
 * User model
 */
class User extends Model {

  defaults() {
    return {
      email: '',
      first_name: '',
      last_name: ''
    }
  }

  fullname() {
    return [this.first_name, this.last_name].join(' ')
  }

  initials() {
    return [this.first_name[0], this.last_name[0]].join('').toUpperCase()
  }
}

export { User }
