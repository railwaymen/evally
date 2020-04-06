import { BasePolicy } from './base_policy'

export class RecruitDocumentPolicy extends BasePolicy{
  get canCreate() {
    return ['admin', 'recruiter'].includes(this.user.role)
  }

  get canEdit() {
    return this.canCreate && this.object.isPersisted
  }
}
