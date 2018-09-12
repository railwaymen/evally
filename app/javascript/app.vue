<template>
  <v-app>
    <router-view></router-view>
    <flash-snackbar></flash-snackbar>
  </v-app>
</template>

<script>
import FlashSnackbar from './components/shared/FlashSnackbar'

export default {
  name: 'App',
  components: { FlashSnackbar }
}
</script>
