import { Model, List } from './base'

class Recruit extends Model {
  static get routes() {
    return {
      recruitsSearchPath: '/v2/recruits/search',
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
