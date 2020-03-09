<template>
  <v-layout row wrap class="align-stretch">
    <v-flex xs10 offset-xs1 lg3 offset-lg0>
      <recruitments-sidebar
        :recruitDocument="recruitDocument"
      />
    </v-flex>

    <v-flex xs12 lg9>
      <v-layout row wrap>
        <v-flex xs12 lg6>
          <evaluation-sidebar />
        </v-flex>

        <v-flex xs12 lg6>
          Comments
        </v-flex>
      </v-layout>
    </v-flex>
  </v-layout>
 </template>

<script>
import { mapGetters } from 'vuex'

import EvaluationSidebar from '@components/recruitments/EvaluationSidebar'
import RecruitmentsSidebar from '@components/recruitments/RecruitmentsSidebar'

export default {
  name: 'RecruitmentsShow',
  components: { EvaluationSidebar, RecruitmentsSidebar },
  computed: {
     ...mapGetters({
      recruitDocument: 'RecruitDocumentsModule/recruitDocument'
    })
  },
  created() {
    this.$store.dispatch('RecruitDocumentsModule/show', this.$route.params.id)
  },
}
</script>
