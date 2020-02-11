<template>
  <div class="box evaluation">
    <v-layout v-if="draft.isPersisted" row wrap>
      <v-flex xs12 lg9>
        <h3 class="evaluation__fullname">{{ draft.employeeFullname }}</h3>
        <h4 class="evaluation__position">{{ draft.employee_position }}</h4>
      </v-flex>

      <v-flex xs12 lg3>
        <v-layout row justify-end>
          <v-flex xs12>
            <div class="date">
              <h5 class="date__value">{{ draft.employeeHiredAt }}</h5>
              <h6 class="date__description">{{ $t('views.drafts.show.hiredOn') }}</h6>
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
            :editable="draft.editable"
          />
        </v-layout>
      </v-flex>
    </v-layout>

    <v-layout v-else row>
      <v-flex xs12>
        <h4 class="box__header">
          {{ $t('views.drafts.index.instruction') }}
        </h4>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

import SectionBox from '@components/drafts/SectionBox'

export default {
  name: 'DraftsShow',
  components: { SectionBox },
  computed: {
    ...mapGetters({
      draft: 'DraftsModule/draft',
      sections: 'DraftsModule/sections',
    })
  },
  watch: {
    $route: {
      immediate: true,
      handler(to, from) {
        this.$store.dispatch('DraftsModule/show', to.params.id)
      }
    }
  },
  beforeDestroy() {
    this.$store.commit('DraftsModule/resetItem')
  }
}
</script>
