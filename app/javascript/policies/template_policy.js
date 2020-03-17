import { BasePolicy } from './base_policy'

export class TemplatePolicy extends BasePolicy{
  get canEdit() {
    return !this.object.editable && this.userPermitted
  }

  get canSave() {
    return this.object.editable && this.userPermitted
  }

  get canDestroy() {
    return this.object.isPersisted && this.userPermitted
  }

  get userPermitted() {
    switch (this.user.role) {
      case 'admin':
        return true
      case 'recruiter':
        return this.object.isForRecruits
      case 'evaluator':
        return Number(this.user.id) === Number(this.object.creator_id)
      default:
        return false
    }
  }
}
