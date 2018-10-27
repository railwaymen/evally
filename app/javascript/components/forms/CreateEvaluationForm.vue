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
      return this.employees.models.map(employee => {
        return { id: employee.id, value: this.employeeFullname(employee) }
      })
    },

    selectableTemplates() {
      return this.templates.models.map(template => {
        return { id: template.id, value: template.name }
      })
    }
  },
  mounted() {
    this.$store.dispatch('EmployeesStore/index')
      .catch( error => {
        this.flash({ error: 'Employees cannot be loaded due to some error: ' + error.message })
      })

    this.$store.dispatch('TemplatesStore/index')
      .catch( error => {
        this.flash({ error: 'Templates cannot be loaded due to some error: ' + error.message })
      })
  }
}
</script>
