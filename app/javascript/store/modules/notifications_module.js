import { coreApiClient } from '@utils/api_clients'

import { Notification, NotificationsList } from '@models/notification'

const initState = () => ({
  recentNotifications: new NotificationsList(),
  notifications: new NotificationsList(),
  unreadCount: 0,
  totalPages: 1,
  loading: 'fetchRecent'
})

const NotificationsModule = {
  namespaced: true,

  state: initState(),

  getters: {
    fetchPageLoading: state => state.loading === 'fetchPage',
    fetchRecentLoading: state => state.loading === 'fetchRecent'
  },

  mutations: {
    REFRESH_NOTIFICATION(state, notification) {
      state.notifications.refresh(notification)
      state.recentNotifications.refresh(notification)
      state.unreadCount -= Number(!notification.unread)
    },
    RESET_STATE(state) {
      Object.assign(state, initState())
    },
    SET_LOADING(state, status) {
      state.loading = status
    },
    SET_NOTIFICATIONS(state, { notifications, total_pages, unread_count }) {
      state.notifications = new NotificationsList(notifications)
      state.unreadCount = unread_count
      state.totalPages = total_pages
    },
    SET_RECENT_NOTIFICATIONS(state, { notifications, unread_count }) {
      state.recentNotifications = new NotificationsList(notifications)
      state.unreadCount = unread_count
    },
  },

  actions: {
    fetchRecentNotifications({ commit }) {
      coreApiClient
        .get(Notification.routes.notificationsPath({ page: 1, per_page: 7 }))
        .then(response => {
          commit('SET_RECENT_NOTIFICATIONS', response.data)
        })
    },
    fetchNotifications({ commit }, { page }) {
      coreApiClient
        .get(Notification.routes.notificationsPath({ page: page, per_page: 25 }))
        .then(response => {
          commit('SET_NOTIFICATIONS', response.data)
        })
    },
    readNotification({ commit }, id) {
      console.log(id)
      coreApiClient
        .put(Notification.routes.readNotificationPath(id))
        .then(response => {
          commit('REFRESH_NOTIFICATION', response.data)
        })
    },
    readAllNotifications({ commit }, params) {
      return new Promise(resolve => {
        coreApiClient
          .put(Notification.routes.readAllNotificationsPath, params)
          .then(response => {
            commit('SET_NOTIFICATIONS', response.data)

            resolve(response.date)
          })
      })
    },
  }
}

export default NotificationsModule
