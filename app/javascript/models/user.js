import { Model, List } from './base'

import moment from 'moment'

class User extends Model {
  get defaults() {
    return {
      id: null,
      email: '',
      email_token: '',
      first_name: '',
      last_name: '',
      role: '',
      status: '',
      last_sign_in_at: null,
      invitation_status: '',
      signature: ''
    }
  }

  get fullname() {
    return [this.first_name, this.last_name].join(' ')
  }

  get initials() {
    return [this.first_name[0], this.last_name[0]].join('').toUpperCase() || '@'
  }

  get isAdmin() {
    return this.role === 'admin'
  }

  get isEvaluator() {
    return this.role === 'evaluator'
  }

  get isRecruiter() {
    return this.role === 'recruiter'
  }

  get labeledEmail() {
    return `${this.fullname} <${this.email}>`
  }

  get lastSignInAt() {
    if (!this.last_sign_in_at) return '---'

    return moment(this.last_sign_in_at).format('DD MMM YYYY, HH:mm')
  }

  static get routes() {
    return {
      profilePath: '/v2/profile',
      profilePasswordPath: '/v2/profile/password',
      sessionPath: '/v2/session',
      usersPath: '/v2/users',
      activeUsersPath: '/v2/users/active',
      userPath: id => `/v2/users/${id}`,
      invitationsPath: '/v2/invitations',
      invitationPath: token => `/v2/invitations/${token}`,
      passwordsPath: '/v2/passwords',
      passwordPath: token => `/v2/passwords/${token}`
    }
  }
}

class UsersList extends List {
  get model() {
    return User
  }
}

export { User, UsersList }
