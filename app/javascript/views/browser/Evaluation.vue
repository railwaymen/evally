<template>
  <div class="box evaluation">
    <v-layout v-if="evaluation.isPersisted" row wrap>
      <v-flex xs12 lg6>
        <h3 class="evaluation__fullname">{{ evaluation.fullname }}</h3>
        <h4 class="evaluation__position">{{ evaluation.position }}</h4>
      </v-flex>

      <v-flex xs12 lg3>
        <div class="date">
          <h5 class="date__value">{{ evaluation.hiredOn }}</h5>
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
import { mapState } from 'vuex'

import { Evaluation } from '@models/evaluation'

import StaticSectionBox from '@components/evaluations/StaticSectionBox'

export default {
  name: 'EmployeesEvaluation',
  components: { StaticSectionBox },
  computed: {
    ...mapState('EmployeesModule', [
      'evaluation',
      'sections'
    ])
  },
  watch: {
    $route: {
      immediate: true,
      handler(to) {
        this.$store.dispatch('EmployeesModule/browseEvaluation', to.params)
      }
    }
  },
  destroyed() {
    this.$store.commit('EmployeesModule/CLEAR_EVALUATION')
  }
}
</script>
