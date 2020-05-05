import { Model, List } from './base'

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
      notificationsPath: '/v2/notifications',
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
