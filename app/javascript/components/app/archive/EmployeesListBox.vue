</<template>
  <div class="search-box mt-4">

    <div class="search-box__input">
      <v-text-field
        append-icon="search"
        label="Search by name"
        box
      ></v-text-field>
    </div>

    <v-expansion-panel class="elevation-0">
      <v-expansion-panel-content
        v-for="(evaluations, group) in groupedEvaluations"
        :key="group"
      >
        <div slot="header">
          <div class="vcard-header">
            <v-icon>person_outline</v-icon>
            <span class="separator"></span>
            {{ employeeFullname(evaluationsEmployee(evaluations)) }}
          </div>
        </div>

        <v-card>
          <v-card-text>
            <div class="vcard pa-2">
              <div class="vcard__info">
                <h3 class="vcard__title">Position</h3>
                <div class="vcard__position">{{ evaluationsEmployee(evaluations).position }}</div>
              </div>

              <div class="vcard__info">
                <h3 class="vcard__title">Cooperation</h3>
                <v-layout row>
                  <v-flex xs6>
                    <div class="vcard__date">{{ evaluationsEmployee(evaluations).hired_at | moment("MMMM Do, YYYY") }}</div>
                    <div class="vcard__date-text">since</div>
                  </v-flex>

                  <v-flex xs6>
                    <div class="vcard__date">December 31st, 2018</div>
                    <div class="vcard__date-text">until</div>
                  </v-flex>
                </v-layout>
              </div>

              <div class="vcard__evaluations">
                <v-list two-line subheader>
                  <v-subheader>List of evaluations ({{ evaluations.length }})</v-subheader>

                  <v-list-tile v-for="evaluation in evaluations" :key="evaluation.id" @click="showEvaluation(evaluation.id)">
                    <v-list-tile-content>
                      <v-list-tile-title>{{ evaluation.template_name }}</v-list-tile-title>
                      <v-list-tile-sub-title>{{ evaluation.completed_at | moment('MMMM YYYY') }}</v-list-tile-sub-title>
                    </v-list-tile-content>
                  </v-list-tile>
                </v-list>
              </div>
            </div>
          </v-card-text>
        </v-card>
      </v-expansion-panel-content>
    </v-expansion-panel>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'EmployeesListBox',
  methods: {
    evaluationsEmployee(evaluations) {
      return evaluations[0].employee
    },

    showEvaluation(evaluation_id) {
      this.$store.commit('EvaluationsStore/one', evaluation_id)
    }
  },
  computed: {
    ...mapGetters({
      evaluations: 'EvaluationsStore/evaluations'
    }),

    groupedEvaluations() {
      return this.$_.groupBy(this.evaluations.models, evaluation => {
        return evaluation.employee.id
      })
    },
  },
  created() {
    this.$store.dispatch('EvaluationsStore/index', { state: ['completed', 'archived'] })
      .catch( error => {
        this.flash({ error: 'Evaluations cannot be loaded due to some error: ' + this.renderError(error.response) })
      })
  },
  beforeDestroy() {
    this.$store.commit('EvaluationsStore/clear')
  }
}
</script>
