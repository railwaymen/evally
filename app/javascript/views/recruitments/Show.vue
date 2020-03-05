<template>
  <v-layout row wrap>
    <v-flex xs10 offset-xs1 lg3 offset-lg0>
      <recruitments-sidebar
        :recruitDocument="recruitDocument"
      />
    </v-flex>
  </v-layout>
 </template>

<script>
import { mapGetters } from 'vuex'
import RecruitmentsSidebar from '@components/recruitments/RecruitmentsSidebar'

export default {
  name: 'RecruitmentsShow',
  components: { RecruitmentsSidebar },
  computed: {
     ...mapGetters({
      recruitDocument: 'RecruitmentsModule/recruitDocument'
    })
  },
  created() {
    this.$store.dispatch('RecruitmentsModule/show', this.$route.params.id)
  },
}
</script>
