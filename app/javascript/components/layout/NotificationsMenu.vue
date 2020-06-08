<template>
  <v-badge
    :content="unreadCount"
    :value="unreadCount > 0"
    color="warning"
    offset-x="20"
    offset-y="20"
    bottom
    overlap
  >
    <v-menu
      :disabled="$route.name === 'notifications_path'"
      transition="slide-y-transition"
      offset-y
      left
    >
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
          <span>{{ $t('components.layout.notificationsMenu.title') }}</span>

          <v-btn
            @click="readAll"
            :disabled="unreadCount === 0"
            color="primary"
            text
            small
          >
            {{ $t('components.layout.notificationsMenu.readAll') }}
          </v-btn>
        </v-subheader>

        <v-list-item v-if="recentNotifications.isEmpty">
          <v-list-item-title>
            {{ $t('components.layout.notificationsMenu.noNotifications') }}
          </v-list-item-title>
        </v-list-item>

        <v-list-item
          v-for="notification in recentNotifications.models"
          :key="notification.id"
          @click="markAsRead(notification)"
        >
          <v-list-item-content :class="{ 'notification--unread': notification.unread }">
            <v-list-item-title>{{ notification.body }}</v-list-item-title>
            <v-list-item-subtitle>{{ notification.createdAtFromNow }}</v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>

        <v-list-item v-if="!recentNotifications.isEmpty">
          <v-list-item-title>
            <v-btn
              @click="$router.push({ name: 'notifications_path' })"
              color="primary"
              text
              small
              block
            >
              {{ $t('components.layout.notificationsMenu.seeMore') }}
            </v-btn>
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
      refreshInterval: null,
      refreshDatetime: null
    }
  },
  methods: {
    ...mapActions('NotificationsModule', [
      'fetchRecentNotifications',
      'readNotification',
      'readAllNotifications'
    ]),
    markAsRead(notification) {
      const { id, unread, notifiable_path } = notification

      if (unread) this.readNotification(id)
      if (notifiable_path) this.$router.push(notifiable_path)
    },
    readAll() {
      this.readAllNotifications({ latest_fetch_at: this.refreshDatetime, page: 1, per_page: 7 })
    }
  },
  computed: {
    ...mapState('NotificationsModule', [
      'recentNotifications',
      'unreadCount'
    ])
  },
  created() {
    this.refreshDatetime = new Date()

    this.refreshInterval = setInterval(() => {
      this.fetchRecentNotifications()
      this.refreshDatetime = new Date()
    }, 300000) // 5 minutes
  },
  destroyed() {
    clearInterval(this.refreshInterval)
  }
}
</script>
