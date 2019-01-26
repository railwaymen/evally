<template>
  <div class="box box--with-content evaluation" data-cy="evaluation-box">
    <v-layout v-if="!employee.isExisting()" row>
      <v-flex xs12>
        <h4 class="no-content__header no-content__header--large">{{ $t('employees.messages.select') }}</h4>
      </v-flex>
    </v-layout>

    <v-layout v-else-if="!isEvaluationPresent" row>
      <v-flex xs12>
        <h4 class="no-content__header no-content__header--large">{{ $t('employees.messages.not_evaluated', { name: employee.fullname() }) }}</h4>
      </v-flex>
    </v-layout>

    <v-layout v-else row wrap>
      <v-flex xs12 lg6>
        <div class="employee">
          <h3 class="employee__fullname">{{ employee.fullname() }}</h3>
          <h4 class="employee__position">{{ employee.position }}</h4>
        </div>
      </v-flex>

      <v-flex xs12 lg6>
        <v-layout row justify-end>
          <v-flex lg4>
            <div class="date">
              <h5 class="date__value">{{ employee.hired_at | moment("MMMM YYYY") }}</h5>
              <h6 class="date__description">{{ $t('evaluations.forms.hired_at') }}</h6>
            </div>
          </v-flex>
          <v-flex v-if="employee.next_evaluation_at && $route.name !== 'browse_page_path'" lg4>
            <div class="date">
              <h5 class="date__value">{{ employee.next_evaluation_at | moment("MMMM YYYY") }}</h5>
              <h6 class="date__description">{{ $t('evaluations.forms.next_review') }}</h6>
            </div>
          </v-flex>
          <v-flex lg4>
            <div class="date">
              <h5 class="date__value">{{ evaluation.completed_at | moment("MMM DD, YYYY") }}</h5>
              <h6 class="date__description">{{ $t('evaluations.forms.completed_at') }}</h6>
            </div>
          </v-flex>
        </v-layout>
      </v-flex>

      <v-flex xs12>
        <v-layout row wrap>
          <evaluation-section-box
            v-for="section in evaluation.sections_attributes"
            :section="section"
            :key="section.id"
          ></evaluation-section-box>
        </v-layout>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

import EvaluationSectionBox from '@/components/evaluations/EvaluationSectionBox'

export default {
  name: 'EmployeeEvaluationBox',
  components: { EvaluationSectionBox },
  computed: {
    ...mapGetters({
      employee: 'EmployeesStore/employee'
    }),

    evaluation() {
      return this.employee.evaluation
    },

    isEvaluationPresent() {
      return !!this.evaluation.id
    }
  }
}
</script>
