<template>
  <v-layout row wrap class="d-flex align-stretch">
    <v-flex xs12 lg6>
      <recruitment-form
        :groups="groups"
        :positions="positions"
        :statuses="statuses"
        :evaluators="evaluators"
        :attachments="attachments"
        @selectFile="file => currentAttachment = file"
      />
    </v-flex>

    <v-flex xs12 lg6>
      <file-previewer :url="currentAttachment.url" />
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
  name: 'RecruitmentsNew',
  components: { FilePreviewer, RecruitmentForm },
  data() {
    return {
      currentAttachment: new Attachment()
    }
  },
  computed: {
     ...mapGetters({
      recruitment: 'RecruitDocumentsModule/recruitDocument',
      attachments: 'RecruitDocumentsModule/attachments',
      evaluators: 'RecruitDocumentsModule/evaluators',
      groups: 'RecruitDocumentsModule/groups',
      statuses: 'RecruitDocumentsModule/statuses',
      positions: 'RecruitDocumentsModule/positions'
    })
  },
   created() {
    this.$store.commit('RecruitDocumentsModule/clearRecruitDocument')
   }
}
</script>
