<template>
  <v-dialog v-model="dialog" persistent :max-width="options.maxWidth">
    <v-card class="pa-3" v-if="!!options">
      <v-card-title>
        <span class="headline">{{ $t(`destroy_modals.${options.model || 'default'}.title`) }}</span>
      </v-card-title>

      <v-card-text>
        <p class="subheading">{{ $t(`destroy_modals.${options.model || 'default'}.confirm`) }}</p>
      </v-card-text>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="grey darken-1" flat @click="dialog = false">{{ $t('buttons.cancel') }}</v-btn>
        <v-btn color="red darken-1" flat @click="destroy">{{ $t('buttons.delete') }}</v-btn>
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
          this.flash({ success: this.$t('evaluations.flashes.delete.success') })
          this.dialog = false
        })
        .catch(error => {
          this.flash({ error: this.$t('evaluations.flashes.delete.error', { reason: this.renderError(error.response) }) })
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
