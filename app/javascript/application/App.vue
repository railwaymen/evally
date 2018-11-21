<template>
  <v-app>
    <router-view></router-view>
    
    <flash-snackbar></flash-snackbar>
  </v-app>
</template>

<script>
import FlashSnackbar from '@/components/shared/FlashSnackbar'

export default {
  name: 'App',
  components: { FlashSnackbar },
  created() {
    let session = JSON.parse(localStorage.getItem('ev411y_s3ssi0n'))
    if (session) this.$store.commit('AuthStore/setSession', session)
  }
}
</script>
