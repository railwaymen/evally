<template>
  <v-dialog v-model="dialog" persistent :max-width="options.maxWidth">

    <complete-evaluation-form
      v-if="options.model === 'evaluation'"
      :options="options"
      @close="dialog = false"
    ></complete-evaluation-form>

    <create-evaluation-form
      v-if="options.model === 'draft'"
      :options="options"
      @close="dialog = false"
    ></create-evaluation-form>

    <archive-employee-form
      v-if="options.model === 'employee' && options.action === 'archive'"
      :options="options"
      @close="dialog = false"
    ></archive-employee-form>

    <employee-form
      v-if="options.model === 'employee' && ['create', 'edit'].indexOf(options.action) !== -1"
      :options="options"
      @close="dialog = false"
    ></employee-form>

    <share-permalink-form
      v-if="options.model === 'info' && options.action === 'permalink'"
      :options="options"
      @close="dialog = false"
    ></share-permalink-form>

  </v-dialog>
</template>

<script>
import openerBus from '@/lib/opener_bus'

import ArchiveEmployeeForm from '@/components/employees/ArchiveEmployeeForm'
import CompleteEvaluationForm from '@/components/evaluations/CompleteEvaluationForm'
import CreateEvaluationForm from '@/components/evaluations/CreateEvaluationForm'
import EmployeeForm from '@/components/employees/EmployeeForm'
import SharePermalinkForm from '@/components/employees/SharePermalinkForm'

export default {
  name: 'FormsModal',
  components: {
    ArchiveEmployeeForm,
    CompleteEvaluationForm,
    CreateEvaluationForm,
    EmployeeForm,
    SharePermalinkForm
  },
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