<template>
  <div class="box box--with-content evaluation">
    <v-layout v-if="evaluation.isExisting()" row wrap>
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
        </v-layout>
      </v-flex>

      <v-flex xs12>
        <v-layout row wrap>
          <evaluation-section-box
            v-for="section in evaluation.sections_attributes"
            :section="section"
            :key="section.id"
            editable
          ></evaluation-section-box>
        </v-layout>
      </v-flex>
    </v-layout>

    <v-layout v-else row>
      <v-flex xs12>
        <h4 class="no-content__header no-content__header--large">Select employee and template to create new evaluation</h4>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

import EvaluationSectionBox from './EvaluationSectionBox'

export default {
  name: 'EvaluationBox',
  components: { EvaluationSectionBox },
  computed: {
    ...mapGetters({
      evaluation: 'EvaluationsStore/evaluation',
    }),

    employee() {
      return this.evaluation.employee
    }
  }
}
</script>
