import { Model, List } from './base'

import moment from 'moment'

class User extends Model {
  get defaults() {
    return {
      id: null,
      email: '',
      first_name: '',
      last_name: '',
      role: '',
      status: '',
      last_sign_in_at: null,
      invitation_accepted_at: null
    }
  }

  get fullname() {
    return [this.first_name, this.last_name].join(' ')
  }

  get initials() {
    return [this.first_name[0], this.last_name[0]].join('').toUpperCase() || '@'
  }

  get lastSignInAt() {
    if (!this.last_sign_in_at) return '---'

    return moment(this.last_sign_in_at).format('MMM DD, YYYY HH:mm')
  }

  get invitationAcceptedAt() {
    if (!this.invitation_accepted_at) return '---'

    return moment(this.invitation_accepted_at).format('MMM DD, YYYY HH:mm')
  }

  static get routes() {
    return {
      profilePath: '/v2/profile',
      profilePasswordPath: '/v2/profile/password',
      sessionPath: '/v2/session',
      usersPath: '/v2/users'
    }
  }
}

class UsersList extends List {
  get model() {
    return User
  }
}

export { User, UsersList }
