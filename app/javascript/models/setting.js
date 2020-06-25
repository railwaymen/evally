import { Model, List } from './base'

class Setting extends Model {
  get defaults() {
    return {
      default_draft_items: 0,
      default_next_evaluation_time: 0,
      default_upcoming_items: 0,
      lang: 'en',
      enable_upcoming_notifications: true
    }
  }

  static get routes() {
    return {
      settingsPath: '/v2/settings'
    }
  }
}

class SettingsList extends List {
  get model() {
    return Setting
  }
}

export { Setting, SettingsList }
