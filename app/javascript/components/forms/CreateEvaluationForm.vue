<template>
  <div class="box pa-4">

		<div class="step">
      <div class="step__header">
        <v-chip color="white" disabled>
          <v-avatar :class="[employee ? 'success' : 'grey darken-4', 'white--text']">
            <v-icon color="white" v-if="employee">done</v-icon>
            <span v-else>1</span>
          </v-avatar>
          <span class="black--text">Select employee</span>
        </v-chip>
      </div>

      <div class="step__content">
        <v-select
          v-model="employee"
          :items="employees"
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
        <span class="black--text">Select template</span>
      </v-chip>

      <div class="step__content">
        <v-select
          v-model="template"
          :items="templates"
          label="Template"
        ></v-select>
      </div>
    </div>

    <div class="step">
      <div class="step__actions text-xs-center">
        <v-btn small color="success" :disabled="!(employee && template)">New evaluation</v-btn>
        <v-btn small color="primary" :disabled="!(employee && template)">Assign template</v-btn>
      </div>
    </div>
	</div>
</template>

<script>
export default {
  name: 'CreateEvaluationForm',
  data() {
    return {
      currentStep: 1,
      employees: ['Joe Doe', 'Jacek Przypadek', 'John Rambo'],
      templates: ['Junior', 'Tester', 'Driver'],
      employee: null,
      template: null
    }
  }
}
</script>
