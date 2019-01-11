<template>
  <v-snackbar v-model="snackbar" :color="message.type" :bottom="true" :timeout="4000" data-cy="flash">
    {{ message.text }}
    <v-btn flat icon color="white" @click="snackbar = false">
      <v-icon>close</v-icon>
    </v-btn>
  </v-snackbar>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'FlashSnackbar',
  data () {
    return {
      snackbar: false
    }
  },
  computed: {
    ...mapGetters({
      hasMessage: 'FlashStore/hasMessage',
      message: 'FlashStore/message'
    })
  },
  mounted () {
    this.$store.watch(context => {
      if (this.hasMessage) {
        this.snackbar = false
        this.$store.dispatch('FlashStore/flash')
          .then(() => { this.snackbar = true })
      }
    })
  }
}
</script>
