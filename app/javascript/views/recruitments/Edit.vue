<template>
  <v-layout row wrap class="d-flex align-stretch">
    <v-flex xs12 lg6>
      <div v-if="loading" class="widget__loader">
				<v-progress-circular :size="30" :width="3" color="primary" indeterminate />
			</div>

      <recruitment-form
        v-else
        :recruitDocument="recruitDocument"
        :groups="groups"
        :positions="positions"
        :statuses="statuses"
        :evaluators="evaluators"
        :attachments="attachments"
        @selectFile="file => currentAttachment = file"
      />
    </v-flex>

    <v-flex xs12 lg6>
      <div v-if="loading" class="widget__loader">
				<v-progress-circular :size="30" :width="3" color="primary" indeterminate />
			</div>

      <file-previewer v-else :attachment="currentAttachment" />
    </v-flex>
  </v-layout>
</template>

<script>
import { mapGetters } from 'vuex'

import { Attachment } from '@models/attachment'
import { RecruitDocument } from '@models/recruit_document'

import FilePreviewer from '@components/shared/FilePreviewer'
import RecruitmentForm from '@components/recruitments/RecruitmentForm'

export default {
  name: 'RecruitmentEdit',
  components: { FilePreviewer, RecruitmentForm },
  data() {
    return {
      currentAttachment: new Attachment()
    }
  },
  computed: {
     ...mapGetters({
      recruitDocument: 'RecruitDocumentsModule/recruitDocument',
      attachments: 'RecruitDocumentsModule/attachments',
      evaluators: 'RecruitDocumentsModule/evaluators',
      groups: 'RecruitDocumentsModule/groups',
      statuses: 'RecruitDocumentsModule/statuses',
      positions: 'RecruitDocumentsModule/positions',
      loading: 'RecruitDocumentsModule/loading'
    })
  },
  watch: {
    $route: {
      immediate: true,
      handler(to) {
        if (to.name === 'edit_recruitment_path') {
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
