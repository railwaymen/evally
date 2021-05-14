<template>
  <v-layout row wrap class="align-stretch">
    <v-flex xs12 lg3 >
      <recruit-document-sidebar
        :recruitDocument="recruitDocument"
        :positions="positions"
        :statuses="statuses"
        :groups="groups"
        :attachments="attachments"
        :evaluators="evaluators"
        :loading="fetchLoading"
      />
    </v-flex>

    <v-flex xs12 lg9>
      <v-layout row wrap>
        <v-flex xs12 lg6>
          <recruitments-sidebar
            :recruitments="currentRecruitments"
            :loading="fetchLoading"
          />

          <evaluations-sidebar
            :templates="templates"
            :evaluations="evaluations"
            :evaluation="evaluation"
            :sections="sections"
            :loading="evaluationLoading"
          />
        </v-flex>

        <v-flex xs12 lg6>
          <comments-sidebar
            :comments="comments"
            :user="user"
            :users="evaluators"
            :recruitDocument="recruitDocument"
            :loading="fetchLoading"
          />
        </v-flex>
      </v-layout>
    </v-flex>
  </v-layout>
</template>

<script>
import { mapState, mapGetters } from 'vuex'

import CommentsSidebar from '@components/recruitments/CommentsSidebar'
import EvaluationsSidebar from '@components/recruitments/EvaluationsSidebar'
import RecruitDocumentSidebar from '@components/recruitments/RecruitDocumentSidebar'
import RecruitmentsSidebar from '@components/recruitments/RecruitmentsSidebar'

export default {
  name: 'RecruitmentsShow',
  components: {
    CommentsSidebar,
    EvaluationsSidebar,
    RecruitDocumentSidebar,
    RecruitmentsSidebar
  },
  computed: {
    ...mapState('RecruitDocumentsModule', [
      'recruitDocument',
      'currentRecruitments',
      'attachments',
      'statuses',
      'groups',
      'positions',
      'evaluators',
      'templates',
      'evaluations',
      'evaluation',
      'sections',
      'comments'
    ]),
    ...mapState('AuthenticationModule', [
      'user'
    ]),
    ...mapGetters('RecruitDocumentsModule', [
      'fetchLoading',
      'evaluationLoading'
    ])
  },
  created() {
    this.$store.dispatch('RecruitDocumentsModule/fetchRecruitDocument', this.$route.params)
  }
}
</script>
