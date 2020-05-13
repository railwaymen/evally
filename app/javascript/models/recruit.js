import { Model, List } from './base'

class Recruit extends Model {
  static get routes() {
    return {
      recruitsSkillsPath: '/v2/recruits/skills',
    }
  }
}

class RecruitsList extends List {
  get model() {
    return Recruit
  }
}

export { Recruit, RecruitsList }
