<template>
  <div class="box box--with-content evaluation">
    <v-layout row wrap>
      <v-flex xs12 lg9>
        <div class="employee">
          <h3 class="employee__fullname">{{ evaluation.employeeFullname }}</h3>
          <h4 class="employee__position">{{ evaluation.employee_position }}</h4>
        </div>
      </v-flex>

      <v-flex xs12 lg3>
        <v-layout row justify-end>
          <v-flex xs12>
            <div class="date">
              <h5 class="date__value">{{ evaluation.employeeHiredAt }}</h5>
              <h6 class="date__description">{{ $t('evaluations.forms.hired_at') }}</h6>
            </div>
          </v-flex>
        </v-layout>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'Evaluation',
  methods: {
    fetchEvaluation(id) {
      this.$store.dispatch('EvaluationsStore/show', id)
        .catch(error => {
          this.flash({ error: this.$root.$t('evaluations.flashes.fetch.error', { reason: this.renderError(error.response) }) })
        })
    }
  },
  computed: {
    ...mapGetters({
      evaluation: 'EvaluationsStore/evaluation',
      sections: 'EvaluationsStore/sections',
    })
  },
  created() {
    this.fetchEvaluation(this.$route.params.id)
  },
  beforeRouteUpdate(to, _from, next) {
    this.fetchEvaluation(to.params.id)

    next()
  },
}
</script>
