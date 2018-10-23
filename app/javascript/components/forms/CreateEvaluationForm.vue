<template>
  <div class="box pa-4">

		<div class="step">
      <div class="step__header">
        <v-chip color="white" disabled>
          <v-avatar :class="[employee ? 'success' : 'grey darken-4', 'white--text']">
            <v-icon color="white" v-if="employee">done</v-icon>
            <span v-else>1</span>
          </v-avatar>
          <span class="step__text black--text">Select employee</span>
        </v-chip>
      </div>

      <div class="step__content">
        <v-select
          v-model="employee"
          :items="selectableEmployees"
          item-value="id"
          item-text="value"
          label="Employee"
        ></v-select>
      </div>
    </div>

    <div class="step">
      <v-chip color="white" disabled>
        <v-avatar :class="[template ? 'success' : 'grey darken-4', 'white--text']">
          <v-icon color="white" v-if="template">done</v-icon>
          <span v-else>2</span>
        </v-avatar>
        <span class="step__text black--text">Select template</span>
      </v-chip>

      <div class="step__content">
        <v-select
          v-model="template"
          :items="selectableTemplates"
          item-value="id"
          item-text="value"
          label="Template"
        ></v-select>
      </div>
    </div>

    <div class="step">
      <div class="step__actions text-xs-center">
        <v-btn small color="success" @click="build" :disabled="!(employee && template)">Create</v-btn>
        <!-- <v-btn small color="primary" :disabled="!(employee && template)">Assign template</v-btn> -->
      </div>
    </div>
	</div>
</template>

<script>
import _ from 'lodash'

import { mapGetters } from 'vuex'

export default {
  name: 'CreateEvaluationForm',
  data() {
    return {
      employee: null,
      template: null
    }
  },
  methods: {
    build() {
      let initialData = { evaluation: { employee_id: this.employee, template_id: this.template } }

      this.$store.dispatch('EvaluationsStore/create', initialData)
        .then(() => {
          this.flash({ success: 'Evaluation has been succefully created.' })
        })
        .catch((err) => {
          this.flash({ error: 'Evaluation cannot be created due to some error' })
        })
    }
  },
  computed: {
    ...mapGetters({
      employees: 'EmployeesStore/employees',
      templates: 'TemplatesStore/templates'
    }),

    selectableEmployees() {
      return _.map(this.employees.models, employee => {
        return { id: employee.id, value: `${employee.first_name} ${employee.last_name}` }
      })
    },

    selectableTemplates() {
      return _.map(this.templates.models, template => {
        return { id: template.id, value: template.name }
      })
    }
  },
  mounted() {
    if (this.employees.models.length === 0) {
      this.$store.dispatch('EmployeesStore/index')
        .catch( error => {
          this.flash({ error: 'Employees cannot be loaded due to some error: ' + error.message })
        })
    }

    if (this.templates.models.length === 0) {
      this.$store.dispatch('TemplatesStore/index')
        .catch( error => {
          this.flash({ error: 'Templates cannot be loaded due to some error: ' + error.message })
        })
    }
  }
}
</script>
