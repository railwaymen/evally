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
import openerBus from '@/lib/opener_bus'

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
        case 'evaluation':
          this.removeEvaluation()
          break
        case 'template':
          this.removeTemplate()
          break
      }
    },

    removeEmployee() {
      this.$store.dispatch('EmployeesStore/destroy')
        .then(() => {
          this.flash({ success: 'Employee has been succesfully destroyed' })
          this.$store.commit('EvaluationsStore/clear')
          this.dialog = false
        })
        .catch(error => {
          this.flash({ error: 'Employee cannot be destroyes due to some error: ' + this.renderError(error.response) })
        })
    },

    removeEvaluation() {
      this.$store.dispatch('EvaluationsStore/destroy')
        .then(() => {
          this.flash({ success: 'Evaluation has been succesfully destroyed' })
          this.dialog = false
        })
        .catch(error => {
          this.flash({ error: 'Evaluation cannot be destroyed due to some error: ' + this.renderError(error.response) })
        })
    },

    removeTemplate() {
      this.$store.dispatch('TemplatesStore/destroy')
        .then(() => {
          this.flash({ success: 'Template has been succesfully destroyed' })
          this.dialog = false
        })
        .catch(error => {
          this.flash({ error: 'Template cannot be destroyed due to some error: ' + this.renderError(error.response) })
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
