<template>
  <v-card class="pa-4">
    <v-card-title>
      <span class="headline">{{ options.action | capitalize }} {{ options.model }}</span>
    </v-card-title>

    <v-form ref="newEvaluationForm">
      <v-card-text>
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
      </v-card-text>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="grey darken-1" flat @click="closeModal">Cancel</v-btn>
        <v-btn color="green darken-1" flat @click="sendForm" :disabled="!(employee && template)">{{ options.action }}</v-btn>
      </v-card-actions>
    </v-form>

	</v-card>
</template>

<script>
import { mapGetters } from 'vuex'

import openerBus from '../../lib/opener_bus'

export default {
  name: 'CreateEvaluationForm',
  props: { options: Object },
  data() {
    return {
      employee: null,
      template: null
    }
  },
  methods: {
    closeModal() {
      this.$refs.newEvaluationForm.reset()
      this.$emit('close')
    },

    sendForm() {
      let initialData = { evaluation: { employee_id: this.employee, template_id: this.template } }

      this.$store.dispatch('EvaluationsStore/create', initialData)
        .then(() => {
          this.flash({ success: 'Evaluation has been succefully created.' })
          if (this.options.redirect) this.$router.push({ name: 'evaluations_path' })
          this.$emit('close')
        })
        .catch(error => {
          console.log(error.response)
          this.flash({ error: 'Evaluation cannot be created due to some error: ' + this.renderError(error.response) })
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
  watch: {
    options(val) {
      this.employee = val.employee_id
    }
  },
  created() {
    this.employee = this.options.employee_id

    this.$store.dispatch('EmployeesStore/index')
      .catch(error => {
        this.flash({ error: 'Employees cannot be loaded due to some error: ' + this.renderError(error.response) })
      })

    this.$store.dispatch('TemplatesStore/index')
      .catch(error => {
        this.flash({ error: 'Templates cannot be loaded due to some error: ' + this.renderError(error.response) })
      })
  }
}
</script>
