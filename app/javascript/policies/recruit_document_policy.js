import { BasePolicy } from './base_policy'

export class RecruitDocumentPolicy extends BasePolicy{
  get canAdd() {
    return ['admin', 'recruiter'].includes(this.user.role)
  }

  get canEdit() {
    return this.canAdd
  }
}
