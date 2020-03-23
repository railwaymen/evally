<template>
  <v-layout row wrap>
    <v-flex xs10 offset-xs1 lg6 offset-lg0>
      <recruitment-form
        :groups="groups"
        :positions="positions"
        :statuses="statuses"
      />
    </v-flex>
  </v-layout>
</template>

<script>
import { mapGetters } from 'vuex'

import { RecruitDocument } from '@models/recruit_document'

import RecruitmentForm from '@components/recruitments/RecruitmentForm'

export default {
  name: 'RecruitmentsNew',
  components: { RecruitmentForm },
  computed: {
     ...mapGetters({
      recruitment: 'RecruitDocumentsModule/recruitDocument',
      groups: 'RecruitDocumentsModule/groups',
      statuses: 'RecruitDocumentsModule/statuses',
      positions: 'RecruitDocumentsModule/positions'
    })
  },
   created() {
    this.$store.dispatch('RecruitDocumentsModule/form')
   }
}
</script>
