<template>
  <v-app>
    <router-view />

    <notifications-bar />
  </v-app>
</template>

<script>
import NotificationsBar from '@components/shared/NotificationsBar'

export default {
  name: 'App',
  components: { NotificationsBar }
}
</script>
