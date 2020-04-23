<template>
  <v-card class="pa-3">
    <v-card-title>
      <span class="headline">{{ $t('components.evaluations.createForm.title') }}</span>
    </v-card-title>

    <v-form @submit.prevent="create">
      <v-card-text>
        <div class="step">
          <div class="step__header">
            <v-chip color="white">
              <v-avatar :class="[employeeId ? 'success' : 'grey darken-4', 'white--text', 'mr-2']">
                <v-icon color="white" v-if="employeeId">mdi-check</v-icon>
                <span v-else>1</span>
              </v-avatar>

              <span class="step__text black--text">
                {{ $t('components.evaluations.createForm.selectEmployee') }}
              </span>
            </v-chip>
          </div>

          <div class="step__content">
            <v-select
              v-model="employeeId"
              :items="employees.models"
              item-value="id"
              item-text="fullname"
              :label="$t('components.evaluations.createForm.employeeLabel')"
              :disabled="defaultEmployee.isPersisted"
            />
          </div>
        </div>

        <div class="step">
          <div class="step__header">
            <v-chip color="white">
              <v-avatar :class="[templateId || useLatest ? 'success' : 'grey darken-4', 'white--text', 'mr-2']">
                <v-icon color="white" v-if="templateId || useLatest">mdi-check</v-icon>
                <span v-else>2</span>
              </v-avatar>

              <span class="step__text black--text">
                {{ $t('components.evaluations.createForm.selectTemplate') }}
              </span>
            </v-chip>
          </div>

          <div class="step__buttons">
            <div class="text-center">
              <v-btn
                @click="setUseLatest(true)"
                :input-value="useLatest"
                text
              >
                {{ $t('components.evaluations.createForm.latestTemplate') }}
              </v-btn>

              <v-btn
                @click="setUseLatest(false)"
                :input-value="newTemplate"
                text
              >
                {{ $t('components.evaluations.createForm.newTemplate') }}
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
              :label="$t('components.evaluations.createForm.templateLabel')"
            />
          </div>
        </div>
      </v-card-text>

      <v-card-actions>
        <v-spacer />
        <v-btn
          @click="closeDialog"
          color="grey darken-1"
          text
        >
          {{ $t('shared.buttons.cancel') }}
        </v-btn>

        <v-btn
          type="submit"
          color="green darken-1"
          :disabled="!formCompleted"
          text
        >
          {{ $t('shared.buttons.create') }}
        </v-btn>
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script>
import { mapActions, mapState } from 'vuex'

import { Employee } from '@models/employee'

export default {
  name: 'CreateForm',
  props: {
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
  methods: {
    ...mapActions('EvaluationEmployablesModule', [
      'createEvaluation',
      'fetchFormData'
    ]),
    closeDialog() {
      this.$emit('closeDialog')
    },
    setUseLatest(val) {
      this.useLatest = val
      this.templateId = null
    },
    create() {
      this.createEvaluation(this.$data)
        .then(data => {
          this.closeDialog()

          this.$router.push({ name: 'evaluation_draft_path', params: { id: data.evaluation.id } })
        })
    }
  },
  computed: {
    ...mapState('EvaluationEmployablesModule', [
      'templates',
      'employees'
    ]),
    newTemplate() {
      return this.useLatest === false
    },
    formCompleted() {
      return this.employeeId && (!!this.useLatest || !!this.templateId)
    }
  },
  created() {
    this.fetchFormData()

    if (this.defaultEmployee.isPersisted) {
      this.employees.push(this.defaultEmployee)
    }
  }
}
</script>
