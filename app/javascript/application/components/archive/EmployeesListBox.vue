</<template>
  <div class="search-box mt-4">

    <div class="search-box__input">
      <v-text-field
        v-model="search"
        append-icon="search"
        :label="$t('archive.sidebar.search')"
        box
      ></v-text-field>
    </div>

    <div class="search-box__list">
      <v-subheader>{{ $t('archive.sidebar.subheader') }}</v-subheader>

      <div v-if="isLoading" class="box__loader">
        <v-progress-circular :size="30" :width="3" color="primary" indeterminate></v-progress-circular>
      </div>

      <v-expansion-panel v-else class="elevation-0">
        <v-expansion-panel-content
          v-for="(evaluations, group) in preparedEvaluations"
          :key="group"
        >
          <div slot="header">
            <div class="vcard-header">
              <v-icon>person_outline</v-icon>
              <span class="separator"></span>
              {{ fullname(evaluationsEmployee(evaluations)) }}
            </div>
          </div>

          <v-card>
            <v-card-text>
              <div class="vcard pa-2">
                <div class="vcard__info">
                  <h3 class="vcard__title">{{ $t('employees.forms.position') }}</h3>
                  <div class="vcard__position">{{ evaluationsEmployee(evaluations).position }}</div>
                </div>

                <div class="vcard__info">
                  <h3 class="vcard__title">{{ $t('employees.forms.cooperation') }}</h3>
                  <v-layout row>
                    <v-flex xs6>
                      <div class="vcard__date">{{ evaluationsEmployee(evaluations).hired_at | moment("MMMM D, YYYY") }}</div>
                      <div class="vcard__date-text">{{ $t('employees.forms.since') }}</div>
                    </v-flex>

                    <v-flex xs6 v-if="evaluationsEmployee(evaluations).state === 'released'">
                      <div class="vcard__date">{{ evaluationsEmployee(evaluations).released_at | moment("MMMM D, YYYY") }}</div>
                      <div class="vcard__date-text">{{ $t('employees.forms.to') }}</div>
                    </v-flex>
                  </v-layout>
                </div>

                <div class="vcard__evaluations">
                  <v-list two-line subheader>
                    <v-subheader>{{ $t('archive.sidebar.evaluations_subheader', { count: evaluations.length }) }}</v-subheader>

                    <v-list-tile v-for="evaluation in evaluations" :key="evaluation.id" @click="pickEvaluation(evaluation.id)">
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

        <v-expansion-panel-content v-if="areEvaluationsEmpty" disabled>
          <div slot="header">
            <div class="vcard-header">
              {{ $t('archive.sidebar.no_items')}}
            </div>
          </div>
        </v-expansion-panel-content>
      </v-expansion-panel>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'EmployeesListBox',
  data() {
    return {
      search: ''
    }
  },
  methods: {
    evaluationsEmployee(evaluations) {
      return evaluations[0].employee
    },

    pickEvaluation(id) {
      this.$store.commit('EvaluationsStore/pick', id)
    }
  },
  computed: {
    ...mapGetters({
      evaluations: 'EvaluationsStore/evaluations',
      status: 'EvaluationsStore/status'
    }),

    preparedEvaluations() {
      let grouped = this.$_.groupBy(this.evaluations.models, evaluation => {
        return evaluation.employee.id
      })

      if (this.search.length > 0) {
        return this.$_.pickBy(grouped, (evaluations, key) => {
          let fullname = this.fullname(evaluations[0].employee)
          return fullname.toLowerCase().indexOf(this.search.toLowerCase()) > -1
        })
      }

      return grouped
    },

    areEvaluationsEmpty() {
      return Object.keys(this.preparedEvaluations).length == 0
    }
  },
  created() {
    this.$store.dispatch('EvaluationsStore/index', { state: ['completed', 'archived'] })
      .catch(error => {
        this.flash({ error: this.$root.$t('evaluations.flashes.fetch.error', { reason: this.renderError(error.response) }) })
      })
  },
  beforeDestroy() {
    this.$store.commit('EvaluationsStore/clear')
  }
}
</script>
