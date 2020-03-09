<template>
  <v-layout row wrap>
    <v-flex xs10 offset-xs1 lg6 offset-lg0>
      <recruitment-form :groups="this.groups"
                        :positions="this.positions"
                        :statuses="this.statuses"/>
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
  data() {
    return {
      groups: ['ruby', 'javascript', 'ux', 'android', 'ios'],
      positions: ['junior', 'regular', 'senior', 'team leader'],
      statuses: ['fresh', 'accepted', 'rejected']
    }
  },
  computed: {
     ...mapGetters({
      recruitment: 'RecruitDocumentsModule/recruitment'
    })
  }
}
</script>
