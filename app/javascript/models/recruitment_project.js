import { Model, List } from './base'

class RecruitmentProject extends Model {
  get defaults() {
    return {
      id: null,
      name: '',
      stages: [],
      started_on: '',
      finished_on: ''
    }
  }
}

class RecruitmentProjectsList extends List {
  get model() {
    return RecruitmentProject
  }
}

export { RecruitmentProject, RecruitmentProjectsList }
