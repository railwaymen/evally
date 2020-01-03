<template>
  <div class="box box--with-content evaluation">
    <v-layout v-if="evaluation.isPersisted" row wrap>
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
        <h4 class="no-content__header no-content__header--large">
          {{ $t('evaluations.message') }}
        </h4>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

import SectionBox from '@components/evaluations/SectionBox'

export default {
  name: 'Evaluation',
  components: { SectionBox },
  computed: {
    ...mapGetters({
      evaluation: 'EvaluationsStore/evaluation',
      sections: 'EvaluationsStore/sections',
    })
  },
  watch: {
    $route: {
      immediate: true,
      handler(to, from) {
        this.$store.dispatch('EvaluationsStore/show', to.params.id)
      }
    }
  },
  beforeDestroy() {
    this.$store.commit('EvaluationsStore/clear')
  }
}
</script>
