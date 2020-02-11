<template>
  <div class="box evaluation">
    <v-layout v-if="evaluation.isPersisted" row wrap>
      <v-flex xs12 lg6>
        <h3 class="evaluation__fullname">{{ evaluation.employeeFullname }}</h3>
        <h4 class="evaluation__position">{{ evaluation.employee_position }}</h4>
      </v-flex>

      <v-flex xs12 lg3>
        <div class="date">
          <h5 class="date__value">{{ evaluation.employeeHiredAt }}</h5>
          <h6 class="date__description">{{ $t('views.employees.evaluation.hiredOn') }}</h6>
        </div>
      </v-flex>

      <v-flex xs12 lg3>
        <div class="date">
          <h5 class="date__value">{{ evaluation.completedAt }}</h5>
          <h6 class="date__description">{{ $t('views.employees.evaluation.completedAt') }}</h6>
        </div>
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

    <v-layout v-else row>
      <v-flex xs12>
        <h4 class="box__header">
          {{ $t('views.employees.show.instruction') }}
        </h4>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

import { Evaluation } from '@models/evaluation'

import StaticSectionBox from '@components/evaluations/StaticSectionBox'

export default {
  name: 'EmployeesEvaluation',
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
