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
          <evaluations-sidebar
            :templates="templates"
            :evaluations="evaluations"
            :evaluation="evaluation"
            :sections="sections"
            :loading="loading"
          />
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

import EvaluationsSidebar from '@components/recruitments/EvaluationsSidebar'
import RecruitmentsSidebar from '@components/recruitments/RecruitmentsSidebar'

export default {
  name: 'RecruitmentsShow',
  components: { EvaluationsSidebar, RecruitmentsSidebar },
  computed: {
     ...mapGetters({
      recruitDocument: 'RecruitDocumentsModule/recruitDocument',
      templates: 'RecruitDocumentsModule/templates',
      evaluations: 'RecruitDocumentsModule/evaluations',
      evaluation: 'RecruitDocumentsModule/evaluation',
      sections: 'RecruitDocumentsModule/sections',
      loading: 'RecruitDocumentsModule/loading'
    })
  },
  created() {
    this.$store.dispatch('RecruitDocumentsModule/show', {
      publicRecruitId: this.$route.params.publicRecruitId,
      id: this.$route.params.id
    })
  },
}
</script>
