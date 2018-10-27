<template>
  <v-dialog v-model="dialog" persistent :max-width="options.maxWidth">

    <complete-evaluation-form v-if="options.model === 'evaluation'" :options="options" @close="dialog = false"></complete-evaluation-form>

    <employee-form v-if="options.model === 'employee'" :options="options" @close="dialog = false"></employee-form>

  </v-dialog>
</template>

<script>
import openerBus from '../../lib/opener_bus'

import CompleteEvaluationForm from '../forms/CompleteEvaluationForm'
import EmployeeForm from '../forms/EmployeeForm'

export default {
  name: 'FormsModal',
  components: { CompleteEvaluationForm, EmployeeForm },
  data () {
    return {
      dialog: false,
      options: {}
    }
  },
  created() {
    openerBus.$on('openFormModal', options => {
      this.options = options
      this.dialog = true
    })
  }
}
</script>