<template>
  <v-dialog v-model="dialog" persistent :max-width="options.maxWidth">
    <v-card class="pa-3">
      <v-card-title>
        <span class="headline">Delete {{ options.model }}</span>
      </v-card-title>

      <v-card-text>
        <p class="subheading">Are you sure you want to delete this {{ options.model }}?</p>
      </v-card-text>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="grey darken-1" flat @click="dialog = false">Cancel</v-btn>
        <v-btn color="red darken-1" flat @click="destroy">{{ options.action }}</v-btn>
      </v-card-actions>

    </v-card>
  </v-dialog>
</template>

<script>
import openerBus from '../../lib/opener_bus'

export default {
  name: 'DestroyModal',
  data () {
    return {
      dialog: false,
      options: {}
    }
  },
  methods: {
    destroy() {
      switch(this.options.model) {
        case 'employee':
          this.removeEmployee()
          break
      }
    },

    removeEmployee() {
      this.$store.dispatch('EmployeesStore/destroy')
        .then(() => {
          this.flash({ success: 'Employees has been succesfully destroyed' })
          this.dialog = false
        })
        .catch(() => {
          this.flash({ error: 'Employees cannot be destroyed due to some error' })
        })
    }
  },
  created() {
    openerBus.$on('openDestroyModal', options => {
      this.options = options
      this.dialog = true
    })
  }
}
</script>
