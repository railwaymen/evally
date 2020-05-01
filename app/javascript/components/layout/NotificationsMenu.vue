<template>
  <v-badge
    :content="unreadNotificationsCount"
    :value="unreadNotificationsCount > 0"
    color="warning"
    offset-x="20"
    offset-y="20"
    bottom
    overlap
  >
    <v-menu transition="slide-y-transition" offset-y left>
      <template #activator="{ on }">
        <v-btn
          v-on="on"
          color="primary"
          icon
        >
          <v-icon>mdi-bell</v-icon>
        </v-btn>
      </template>

      <v-list min-width="420" subheader>
        <v-subheader class="notification__subheader">
          <span>Notifications</span>
          <v-btn color="primary" text small>Read All</v-btn>
        </v-subheader>

        <v-list-item v-if="notifications.isEmpty">
          <v-list-item-title>There is no notifications yet</v-list-item-title>
        </v-list-item>

        <v-list-item
          v-for="notification in notifications.models"
          :key="notification.id"
          :to="notification.notifiable_path"
          active-class="no-active"
          @click="markAsRead(notification)"
        >
          <v-list-item-content :class="{ 'notification--unread': notification.unread }">
            <v-list-item-title>{{ notification.body }}</v-list-item-title>
            <v-list-item-subtitle>{{ notification.createdAtFromNow }}</v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>

        <v-list-item v-if="notifications.models.length > 0 ">
          <v-list-item-title>
            <v-btn color="primary" text small block>See More</v-btn>
          </v-list-item-title>
        </v-list-item>
      </v-list>
    </v-menu>
  </v-badge>
</template>

<script>
import { mapActions, mapState } from 'vuex'

export default {
  name: 'NotificationsMenu',
  data() {
    return {
      refreshInterval: null
    }
  },
  methods: {
    ...mapActions('AuthenticationModule', [
      'fetchNotifications',
      'readNotification'
    ]),
    markAsRead(notification) {
      if (notification.unread) this.readNotification(notification.id)
    }
  },
  computed: {
    ...mapState('AuthenticationModule', [
      'notifications',
      'unreadNotificationsCount'
    ])
  },
  created() {
    this.refreshInterval = setInterval(this.fetchNotifications, 300000) // 5 minutes
  },
  destroyed() {
    clearInterval(this.refreshInterval)
  }
}
</script>
