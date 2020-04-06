<template>
  <v-layout row wrap class="align-stretch">
    <v-flex xs12 lg3 >
      <recruitments-sidebar
        :recruitDocument="recruitDocument"
        :positions="positions"
        :statuses="statuses"
        :groups="groups"
        :attachments="attachments"
        :evaluators="evaluators"
        :policy="policy"
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
          <comments-sidebar />
        </v-flex>
      </v-layout>
    </v-flex>
  </v-layout>
</template>

<script>
import { mapGetters } from 'vuex'

import { RecruitDocumentPolicy } from '@policies/recruit_document_policy'

import CommentsSidebar from '@components/recruitments/CommentsSidebar'
import EvaluationsSidebar from '@components/recruitments/EvaluationsSidebar'
import RecruitmentsSidebar from '@components/recruitments/RecruitmentsSidebar'

export default {
  name: 'RecruitmentsShow',
  components: { CommentsSidebar, EvaluationsSidebar, RecruitmentsSidebar },
  computed: {
    policy() {
      return new RecruitDocumentPolicy(this.user, this.recruitDocument)
    },
    ...mapGetters({
      recruitDocument: 'RecruitDocumentsModule/recruitDocument',
      attachments: 'RecruitDocumentsModule/attachments',
      statuses: 'RecruitDocumentsModule/statuses',
      groups: 'RecruitDocumentsModule/groups',
      positions: 'RecruitDocumentsModule/positions',
      templates: 'RecruitDocumentsModule/templates',
      evaluators: 'RecruitDocumentsModule/evaluators',
      evaluations: 'RecruitDocumentsModule/evaluations',
      evaluation: 'RecruitDocumentsModule/evaluation',
      sections: 'RecruitDocumentsModule/sections',
      loading: 'RecruitDocumentsModule/loading',
      user: 'AuthenticationModule/user'
    })
  },
  watch: {
    $route: {
      immediate: true,
      handler(to) {
        if (to.name === 'recruitment_path') {
          this.$store.dispatch('RecruitDocumentsModule/show', {
            publicRecruitId: to.params.publicRecruitId,
            id: to.params.id
          })
        }
      }
    }
  }
}
</script>
