<template>
  <v-layout row wrap>
    <v-flex
      v-for="recruitment in recruitments.models"
      :key="recruitment.id"
      xs12
    >
      <recruitment-row :recruitment="recruitment" />
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
