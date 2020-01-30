<template>
  <v-card class="pa-3">
    <v-card-title>
      <span class="headline">{{ $t('evaluations.forms.create_title') }}</span>
    </v-card-title>

    <v-form @submit.prevent="create">
      <v-card-text>
        <div class="step">
          <div class="step__header">
            <v-chip color="white" disabled>
              <v-avatar :class="[employeeId ? 'success' : 'grey darken-4', 'white--text']">
                <v-icon color="white" v-if="employeeId">done</v-icon>
                <span v-else>1</span>
              </v-avatar>
              <span class="step__text black--text">{{ $t('evaluations.forms.select_employee') }}</span>
            </v-chip>
          </div>

          <div class="step__content">
            <v-select
              v-model="employeeId"
              :items="employees.models"
              item-value="id"
              item-text="fullname"
              :label="$t('evaluations.forms.employee_label')"
              :disabled="defaultEmployee.isPersisted"
            />
          </div>
        </div>

        <div class="step">
          <div class="step__header">
            <v-chip color="white" disabled>
              <v-avatar :class="[templateId || useLatest ? 'success' : 'grey darken-4', 'white--text']">
                <v-icon color="white" v-if="templateId || useLatest">done</v-icon>
                <span v-else>2</span>
              </v-avatar>
              <span class="step__text black--text">{{ $t('evaluations.forms.select_template') }}</span>
            </v-chip>
          </div>

          <div class="step__buttons">
            <div class="text-xs-center">
              <v-btn
                @click="setUseLatest(true)"
                :input-value="useLatest"
                flat
              >
                Latest Template
              </v-btn>

              <v-btn
                @click="setUseLatest(false)"
                :input-value="newTemplate"
                flat
              >
                New Template
              </v-btn>
            </div>
          </div>

          <div class="step__content">
            <v-select
              v-if="newTemplate"
              v-model="templateId"
              :items="templates.models"
              item-value="id"
              item-text="name"
              :label="$t('evaluations.forms.template_label')"
            />
          </div>
        </div>
      </v-card-text>

      <v-card-actions>
        <v-spacer />
        <v-btn
          @click="closeDialog"
          color="grey darken-1"
          flat
        >
          {{ $t('buttons.cancel') }}
        </v-btn>

        <v-btn
          type="submit"
          color="green darken-1"
          flat
          :disabled="!formCompleted"
        >
          {{ $t('buttons.create') }}
        </v-btn>
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script>
import { Employee, EmployeesList } from '@models/employee'
import { TemplatesList } from '@models/template'

export default {
  name: 'CreateForm',
  props: {
    employees: {
      type: EmployeesList,
      required: false,
      default: () => new EmployeesList()
    },
    templates: {
      type: TemplatesList,
      required: true,
      default: () => new TemplatesList()
    },
    defaultEmployee: {
      type: Employee,
      required: false,
      default: () => new Employee()
    }
  },
  data() {
    return {
      employeeId: this.defaultEmployee.id,
      templateId: null,
      useLatest: null
    }
  },
  computed: {
    newTemplate() {
      return this.useLatest === false
    },
    formCompleted() {
      return this.employeeId && (!!this.useLatest || !!this.templateId)
    }
  },
  methods: {
    closeDialog() {
      this.$emit('closeDialog')
    },
    setUseLatest(val) {
      this.useLatest = val
      this.templateId = null
    },
    create() {
      this.$store.dispatch('DraftsModule/create', this.$data)
        .then(data => {
          this.closeDialog()

          this.$router.push({ name: 'draft_path', params: { id: data.draft.id } })
        })
    }
  },
  created() {
    if (this.defaultEmployee.isNewRecord) return

    this.employees.add(this.defaultEmployee)
  }
}
</script>
