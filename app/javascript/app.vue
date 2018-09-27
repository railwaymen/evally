<template>
  <v-app>
    <router-view></router-view>

    <flash-snackbar></flash-snackbar>
    <forms-modal></forms-modal>
  </v-app>
</template>

<script>
import FlashSnackbar from './components/shared/FlashSnackbar'
import FormsModal from './components/shared/FormsModal'

export default {
  name: 'App',
  components: { FlashSnackbar, FormsModal }
}
</script>
