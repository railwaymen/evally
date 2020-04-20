<template>
  <div class="box evaluation">
    <v-layout v-if="evaluation.isPersisted" row wrap>
      <v-flex xs12 lg9>
        <h3 class="evaluation__fullname">{{ evaluation.fullname }}</h3>
        <h4 class="evaluation__position">{{ evaluation.position }}</h4>
      </v-flex>

      <v-flex xs12 lg3>
        <v-layout row justify-end>
          <v-flex xs12>
            <div class="date">
              <h5 class="date__value">{{ evaluation.hiredOn }}</h5>
              <h6 class="date__description">{{ $t('views.evaluations.show.hiredOn') }}</h6>
            </div>
          </v-flex>
        </v-layout>
      </v-flex>

      <v-flex xs12>
        <v-layout row wrap>
          <section-box
            v-for="section in sections.models"
            :section="section"
            :key="section.id"
            :editable="evaluation.editable"
          />
        </v-layout>
      </v-flex>
    </v-layout>

    <v-layout v-else row>
      <v-flex xs12>
        <h4 class="box__header">
          {{ $t('views.evaluations.index.instruction') }}
        </h4>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapState } from 'vuex'

import SectionBox from '@components/evaluations/SectionBox'

export default {
  name: 'DraftEvaluationShow',
  components: { SectionBox },
  computed: {
    ...mapState('EvaluationEmployablesModule', [
      'evaluation',
      'sections'
    ])
  },
  watch: {
    $route: {
      immediate: true,
      handler(to) {
        this.$store.dispatch('EvaluationEmployablesModule/fetchEvaluation', to.params.id)
      }
    }
  },
  destroyed() {
    this.$store.commit('EvaluationEmployablesModule/CLEAR_EVALUATION')
  }
}
</script>
