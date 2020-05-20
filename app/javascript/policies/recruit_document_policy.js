import { BasePolicy } from './base_policy'

export default class RecruitDocumentPolicy extends BasePolicy{
  get canCreate() {
    return this.user ? (this.user.isAdmin || this.user.isRecruiter) : false
  }

  get canEdit() {
    return this.canCreate
  }

  get canRemove() {
    return this.canCreate
  }

  get canSeeOverview() {
    return this.canCreate
  }
}
