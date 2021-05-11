<template>
  <v-layout row wrap>
    <v-flex v-if="recruitments.isEmpty && !loading" xs12>
      <div class="box mb-4">
        <h4 class="box__header">
          {{ $t('views.recruitments.index.noRecruitments') }}
        </h4>
      </div>
    </v-flex>

    <v-flex
      v-else
      v-for="recruitment in recruitments.models"
      :key="recruitment.id"
      xs12
    >
      <recruitment-row
        :recruitment="recruitment"
        :candidates-group="candidatesTree[recruitment.id]"
      />
    </v-flex>
  </v-layout>
</template>

<script>
import { mapState } from 'vuex'

import RecruitmentRow from '@components/recruitments/RecruitmentRow'

export default {
  name: 'Recruitments',
  components: { RecruitmentRow },
  computed: {
    ...mapState('RecruitmentsModule', [
      'recruitments',
      'candidatesTree',
      'loading'
    ])
  },
  created() {
    this.$store.dispatch('RecruitmentsModule/fetchRecruitments')
  },
  destroyed() {
    this.$store.commit('RecruitmentsModule/RESET_STATE')
  }
}
</script>
