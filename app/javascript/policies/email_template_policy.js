import { BasePolicy } from './base_policy'

export default class EmailTemplatePolicy extends BasePolicy {
  get canIndex() {
    return this.user ? (this.user.isAdmin || this.user.isRecruiter) : false
  }
}
