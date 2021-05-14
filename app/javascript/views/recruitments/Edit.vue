<template>
  <v-layout row wrap class="d-flex align-stretch">
    <v-flex xs12 lg6>
      <div v-if="fetchLoading" class="widget__loader">
				<v-progress-circular :size="30" :width="3" color="primary" indeterminate />
			</div>

      <recruit-document-form
        v-else
        :key="recruitDocument.id"
        :recruitDocument="recruitDocument"
        :groups="groups"
        :positions="positions"
        :statuses="statuses"
        :sources="sources"
        :evaluators="evaluators"
        :attachments="attachments"
        @selectFile="file => localAttachment = file"
      />
    </v-flex>

    <v-flex xs12 lg6>
      <div v-if="fetchLoading" class="widget__loader">
				<v-progress-circular :size="30" :width="3" color="primary" indeterminate />
			</div>

      <file-previewer v-else :attachment="currentAttachment" />
    </v-flex>
  </v-layout>
</template>

<script>
import { mapGetters, mapState } from 'vuex'

import { Attachment } from '@models/attachment'
import { RecruitDocument } from '@models/recruit_document'

import FilePreviewer from '@components/shared/FilePreviewer'
import RecruitDocumentForm from '@components/recruitments/RecruitDocumentForm'

export default {
  name: 'RecruitmentEdit',
  components: { FilePreviewer, RecruitDocumentForm },
  data() {
    return {
      localAttachment: null
    }
  },
  computed: {
    ...mapState('RecruitDocumentsModule', [
      'recruitDocument',
      'attachments',
      'evaluators',
      'groups',
      'statuses',
      'positions',
      'sources'
    ]),
    ...mapGetters('RecruitDocumentsModule', [
      'fetchLoading'
    ]),
    currentAttachment() {
      return this.localAttachment || this.attachments.defaultPreviewFile || new Attachment()
    }
  },
  watch: {
    $route: {
      immediate: true,
      handler(to) {
        this.$store.dispatch('RecruitDocumentsModule/fetchRecruitDocument', to.params)
      }
    }
  }
}
</script>
