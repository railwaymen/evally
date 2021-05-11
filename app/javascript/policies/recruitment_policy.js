import { BasePolicy } from './base_policy'

export default class RecruitmentPolicy extends BasePolicy{
  get canManage() {
    return this.user ? (this.user.isAdmin || this.user.isRecruiter) : false
  }

  get canEdit() {
    return this.canManage && !this.object.isCompleted
  }
}
