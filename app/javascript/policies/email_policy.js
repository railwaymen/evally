import { BasePolicy } from './base_policy'

export default class EmailPolicy extends BasePolicy {
  get canSend() {
    // return this.user ? (this.user.isAdmin || this.user.isRecruiter) : false
    return false
  }
}
