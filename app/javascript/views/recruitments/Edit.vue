<template>
  <v-layout row wrap class="d-flex align-stretch">
    <v-flex xs12 lg6>
      <div v-if="loading" class="widget__loader">
				<v-progress-circular :size="30" :width="3" color="primary" indeterminate />
			</div>

      <recruitment-form
        v-else
        :key="recruitDocument.id"
        :recruitDocument="recruitDocument"
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
      <div v-if="loading" class="widget__loader">
				<v-progress-circular :size="30" :width="3" color="primary" indeterminate />
			</div>

      <file-previewer v-else :attachment="currentAttachment" />
    </v-flex>
  </v-layout>
</template>

<script>
import { mapState } from 'vuex'

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
    ...mapState('RecruitDocumentsModule', [
      'recruitDocument',
      'attachments',
      'evaluators',
      'groups',
      'statuses',
      'positions',
      'sources',
      'loading'
    ])
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
