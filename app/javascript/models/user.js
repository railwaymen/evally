import { Model, List } from './base'

class User extends Model {
  get defaults() {
    return {
      id: null,
      email: '',
      first_name: '',
      last_name: '',
    }
  }

  get fullname() {
    return [this.first_name, this.last_name].join(' ')
  }

  get initials() {
    return [this.first_name[0], this.last_name[0]].join('').toUpperCase() || '@'
  }

  static get routes() {
    return {
      profilePath: '/v2/profile',
      profilePasswordPath: '/v2/profile/password',
      sessionPath: '/v2/session'
    }
  }
}

class UsersList extends List {
  get model() {
    return User
  }
}

export { User, UsersList }
