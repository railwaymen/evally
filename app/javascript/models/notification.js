import { Model, List } from './base'
import { getURLParams } from '@utils/helpers'

import moment from 'moment'

class Notification extends Model {
  get defaults() {
    return {
      id: null,
      body: '',
      notifiable_path: '',
      created_at: '',
      unread: false
    }
  }

  get createdAtFromNow() {
    return moment(this.created_at).fromNow()
  }

  static get routes() {
    return {
      notificationsPath: payload => `/v2/notifications?${getURLParams(payload)}`,
      readNotificationPath: id => `/v2/notifications/${id}/read`,
      readAllNotificationsPath: '/v2/notifications/read_all'
    }
  }
}

class NotificationsList extends List {
  get model() {
    return Notification
  }
}

export { Notification, NotificationsList }
