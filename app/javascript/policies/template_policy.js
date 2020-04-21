import { BasePolicy } from './base_policy'

export default class TemplatePolicy extends BasePolicy{
  get canEdit() {
    return this.userPermitted && !this.object.editable
  }

  get canSave() {
    return (this.userPermitted || this.object.isNew) && this.object.editable
  }

  get canRemove() {
    return this.userPermitted && this.object.isPersisted
  }

  get userIsCreator() {
    return Number(this.user.id) === Number(this.object.creator_id)
  }

  get userPermitted() {
    if (!this.user) return false

    switch (this.user.role) {
      case 'admin':
        return true
      case 'recruiter':
        return this.object.isForRecruits || this.userIsCreator
      case 'evaluator':
        return this.userIsCreator
      default:
        return false
    }
  }
}
