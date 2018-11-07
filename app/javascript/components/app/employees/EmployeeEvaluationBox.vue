<template>
  <div class="box box--with-content evaluation">
    <v-layout v-if="!evaluation" row>
      <v-flex xs12>
        <h4 class="no-content__header no-content__header--large">{{ employeeFullname(employee) }} has not been evaluated yet</h4>
      </v-flex>
    </v-layout>

    <v-layout v-else-if="!evaluation.isExisting()" row>
      <v-flex xs12>
        <h4 class="no-content__header no-content__header--large">Select employee to see his evaluation</h4>
      </v-flex>
    </v-layout>

    <v-layout v-else row wrap>
      <v-flex xs6>
        <div class="employee">
          <h3 class="employee__fullname">{{ employeeFullname(employee) }}</h3>
          <h4 class="employee__position">{{ employee.position }}</h4>
        </div>
      </v-flex>

      <v-flex xs6>
        <v-layout row justify-end>
          <v-flex xs4>
            <div class="date">
              <h5 class="date__value">{{ employee.hired_at | moment("MMMM YYYY") }}</h5>
              <h6 class="date__description">on board since</h6>
            </div>
          </v-flex>
          <v-flex v-if="employee.next_evaluation_at" xs4>
            <div class="date">
              <h5 class="date__value">{{ employee.next_evaluation_at | moment("MMMM YYYY") }}</h5>
              <h6 class="date__description">next evaluation at</h6>
            </div>
          </v-flex>
          <v-flex xs4>
            <div class="date">
              <h5 class="date__value">{{ evaluation.completed_at | moment("MMM DD, YYYY") }}</h5>
              <h6 class="date__description">completed at</h6>
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

import EvaluationSectionBox from '../evaluations/EvaluationSectionBox'

export default {
  name: 'EmployeeEvaluationBox',
  components: { EvaluationSectionBox },
  computed: {
    ...mapGetters({
      evaluation: 'EvaluationsStore/evaluation',
      storedEmployee: 'EmployeesStore/employee'
    }),

    employee() {
      return this.storedEmployee.isExisting() ? this.storedEmployee : this.evaluation.employee
    }
  }
}
</script>
