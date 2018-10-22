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
          <v-flex xs4 v-if="employee.hired_at">
            <div class="date">
              <h5 class="date__value">{{ employee.hired_at | moment("MMMM YYYY") }}</h5>
              <h6 class="date__description">on board since</h6>
            </div>
          </v-flex>
          <v-flex xs4>
            <div class="date">
              <v-menu
                ref="menu1"
                :close-on-content-click="false"
                v-model="menu"
                :nudge-right="40"
                :return-value.sync="formattedDate"
                lazy
                transition="scale-transition"
                offset-y
                full-width
                min-width="290px"
              >
                <v-text-field
                  slot="activator"
                  v-model="formattedDate"
                  label="next evaluation at"
                  append-icon="event"
                  readonly
                ></v-text-field>
                <v-date-picker
                  type="month"
                  v-model="next_evaluation_at"
                  @input="$refs.menu1.save(next_evaluation_at)"
                  :min="$moment().format()"
                  no-title scrollable></v-date-picker>
              </v-menu>
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
  data() {
    return {
      menu: false,
      next_evaluation_at: this.$moment().add(6, 'M').format()
    }
  },
  methods: {
    employeeFullname(employee) {
      return `${employee.first_name} ${employee.last_name}`
    }
  },
  computed: {
    ...mapGetters({
      evaluation: 'EvaluationsStore/evaluation',
    }),

    employee() {
      return this.evaluation.employee
    },

    formattedDate: {
      get() {
        return this.$moment(this.next_evaluation_at).format('MMMM YYYY')
      },

      set(date) {
        this.next_evaluation_at = this.$moment(date, 'YYYY-MM').format()
      }
    }
  }
}
</script>
