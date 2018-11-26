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
    let fullname = [this.first_name, this.last_name].join(' ').trim()
    return fullname || this.email
  }

  initials() {
    let initials = [this.first_name[0], this.last_name[0]].join('').toUpperCase()
    return initials || '@'
  }
}

export { User }
