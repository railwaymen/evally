<template>
  <v-layout row wrap class="d-flex align-stretch">
    <v-flex xs12 lg6>
      <recruitment-form
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
import { mapGetters } from 'vuex'

import { Attachment } from '@models/attachment'
import { RecruitDocument } from '@models/recruit_document'

import FilePreviewer from '@components/shared/FilePreviewer'
import RecruitmentForm from '@components/recruitments/RecruitmentForm'

export default {
  name: 'RecruitmentNew',
  components: { FilePreviewer, RecruitmentForm },
  data() {
    return {
      currentAttachment: new Attachment()
    }
  },
  computed: {
     ...mapGetters({
      attachments: 'RecruitDocumentsModule/attachments',
      evaluators: 'RecruitDocumentsModule/evaluators',
      groups: 'RecruitDocumentsModule/groups',
      statuses: 'RecruitDocumentsModule/statuses',
      positions: 'RecruitDocumentsModule/positions',
      sources: 'RecruitDocumentsModule/sources'
    })
  },
  watch: {
    $route: {
      immediate: true,
      handler(to) {
        if (to.name === 'new_recruitment_path') {
          this.$store.dispatch('RecruitDocumentsModule/newForm')
        }
      }
    }
  }
}
</script>
