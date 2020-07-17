import { BasePolicy } from './base_policy'

export default class EmployeePolicy extends BasePolicy{
  get canShow() {
    return true
  }

  get canCreate() {
    return this.user ? (this.user.isAdmin || this.user.isRecruiter) : false
  }

  get canArchive() {
    return this.canCreate
  }

  get canRestore() {
    return this.canCreate
  }

  get canEdit() {
    return this.canCreate
  }

  get canRemove() {
    return this.user && this.user.isAdmin
  }

  get canAddEvaluation() {
    return this.user && (this.user.isAdmin || this.user.id === this.object.evaluator_id)
  }

  get canSeeEvaluation() {
    return this.canAddEvaluation
  }

  get canSeeCopyLink() {
    return this.user && (this.user.isAdmin || this.user.id === this.object.evaluator_id)
  }

  get canSeeOverview() {
    return this.canCreate
  }
}
