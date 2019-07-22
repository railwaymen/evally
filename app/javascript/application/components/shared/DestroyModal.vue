<template>
  <v-dialog v-model="dialog" persistent :max-width="options.maxWidth">
    <v-card class="pa-3" v-if="!!options" data-cy="delete-modal">
      <v-card-title>
        <span class="headline">{{ $t(`destroy_modals.${options.model || 'default'}.title`) }}</span>
      </v-card-title>

      <v-card-text>
        <p class="subheading">{{ $t(`destroy_modals.${options.model || 'default'}.confirm`) }}</p>
      </v-card-text>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="grey darken-1" flat @click="dialog = false" data-cy="btn-cancel">{{ $t('buttons.cancel') }}</v-btn>
        <v-btn color="red darken-1" flat @click="destroy" data-cy="btn-delete">{{ $t('buttons.delete') }}</v-btn>
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
          this.flash({ success: this.$root.$t('employees.flashes.delete.success') })
          this.$store.commit('EvaluationsStore/clear')
          this.dialog = false
          this.$router.push({ name: 'employees_path' })
        })
        .catch(error => {
          this.flash({ error: this.$root.$t('employees.flashes.delete.error', { reason: this.renderError(error.response) }) })
        })
    },

    removeEvaluation() {
      this.$store.dispatch('EvaluationsStore/destroy')
        .then(() => {
          this.flash({ success: this.$root.$t('evaluations.flashes.delete.success') })
          this.dialog = false
        })
        .catch(error => {
          this.flash({ error: this.$root.$t('evaluations.flashes.delete.error', { reason: this.renderError(error.response) }) })
        })
    },

    removeTemplate() {
      this.$store.dispatch('TemplatesStore/destroy')
        .then(() => {
          this.flash({ success: this.$root.$t('templates.flashes.delete.success') })
          this.dialog = false
        })
        .catch(error => {
          this.flash({ error: this.$root.$t('templates.flashes.delete.error', { reason: this.renderError(error.response) }) })
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
