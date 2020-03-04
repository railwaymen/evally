<template>
  <v-layout row wrap>
    <v-flex xs10 offset-xs1 lg3 offset-lg0>
      <recruitments-sidebar
        :recruitment="recruitment"
      />
    </v-flex>
  </v-layout>
 </template>

<script>
import { mapGetters } from 'vuex'
import { Recruitment } from '@models/recruitment'
import RecruitmentsSidebar from '@components/recruitments/RecruitmentsSidebar'

export default {
  name: 'RecruitmentsShow',
  components: { RecruitmentsSidebar },
  computed: {
     ...mapGetters({
      recruitment: 'RecruitmentsModule/recruitment'
    })
  },
  created() {
    this.$store.dispatch('RecruitmentsModule/show', this.$route.params.id)
  },
}
</script>
