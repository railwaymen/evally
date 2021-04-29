<template>
  <v-layout row wrap class="d-flex align-stretch">
    <v-flex xs12 lg6>
      <recruit-document-form
        :groups="groups"
        :positions="positions"
        :statuses="statuses"
        :sources="sources"
        :evaluators="evaluators"
        :attachments="attachments"
        @selectFile="file => currentAttachment = file"
      />
    </v-flex>

    <v-flex xs12 lg6>
      <file-previewer :attachment="currentAttachment" />
    </v-flex>
  </v-layout>
</template>

<script>
import { mapState } from 'vuex'

import { Attachment } from '@models/attachment'
import { RecruitDocument } from '@models/recruit_document'

import FilePreviewer from '@components/shared/FilePreviewer'
import RecruitDocumentForm from '@components/recruitments/RecruitDocumentForm'

export default {
  name: 'RecruitmentNew',
  components: { FilePreviewer, RecruitDocumentForm },
  data() {
    return {
      currentAttachment: new Attachment()
    }
  },
  computed: {
    ...mapState('RecruitDocumentsModule', [
      'attachments',
      'evaluators',
      'groups',
      'statuses',
      'positions',
      'sources'
    ])
  },
  watch: {
    $route: {
      immediate: true,
      handler(to) {
        this.$store.dispatch('RecruitDocumentsModule/newRecruitDocument', to.params)
      }
    }
  }
}
</script>
