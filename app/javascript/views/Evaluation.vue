<template>
  <div class="box evaluation">
    <v-layout row wrap>
      <v-flex xs12 lg9>
        <h3 class="evaluation__fullname">{{ evaluation.employeeFullname }}</h3>
        <h4 class="evaluation__position">{{ evaluation.employee_position }}</h4>
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

      <v-flex xs12>
        <v-layout row wrap>
          <static-section-box
            v-for="section in sections.models"
            :section="section"
            :key="section.id"
          />
        </v-layout>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

import { Evaluation } from '@models/evaluation'

import StaticSectionBox from '@components/evaluations/StaticSectionBox'

export default {
  name: 'Evaluation',
  components: { StaticSectionBox },
  computed: {
    ...mapGetters({
      evaluation: 'EmployeesModule/evaluation',
      sections: 'EmployeesModule/sections'
    })
  },
  watch: {
    $route: {
      immediate: true,
      handler(to, from) {
        this.$store.dispatch('EmployeesModule/showEvaluation', to.params.id)
      }
    }
  },
  beforeDestroy() {
    this.$store.commit('EmployeesModule/resetEvaluation')
  }
}
</script>
