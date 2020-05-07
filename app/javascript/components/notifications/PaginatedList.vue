<template>
  <div class="sidebar sidebar--boxed">
    <div class="sidebar__section">
      <v-list subheader>
        <v-subheader>
          <v-spacer />

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

        <v-list-item v-if="notifications.isEmpty">
          <v-list-item-title>
            {{ $t('components.layout.notificationsMenu.noNotifications') }}
          </v-list-item-title>
        </v-list-item>

        <v-list-item
          v-for="notification in notifications.models"
          :key="notification.id"
          @click="markAsRead(notification)"
        >
          <v-list-item-content :class="{ 'notification--unread': notification.unread }">
            <v-list-item-title>{{ notification.body }}</v-list-item-title>
            <v-list-item-subtitle>{{ notification.createdAtFromNow }}</v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
      </v-list>

      <v-pagination v-model="page" :length="totalPages" class="my-4" />
    </div>
  </div>
</template>

<script>
import { mapActions, mapState } from 'vuex'

export default {
  name: 'PaginatedList',
  data() {
    return {
      page: 1,
      latestFetchAt: new Date()
    }
  },
  methods: {
    ...mapActions('NotificationsModule', [
      'fetchNotifications',
      'readNotification',
      'readAllNotifications'
    ]),
    markAsRead(notification) {
      if (notification.unread) this.readNotification(notification.id)

      this.$router.push(notification.notifiable_path)
    },
    readAll() {
      this.readAllNotifications({ latest_fetch_at: this.latestFetchAt, page: this.page })
    }
  },
  computed: {
    ...mapState('NotificationsModule', [
      'notifications',
      'unreadCount',
      'totalPages'
    ])
  },
  watch: {
    page: {
      immediate: true,
      handler(nextPage) {
        this.fetchNotifications({ page: nextPage })
      }
    }
  }
}
</script>
