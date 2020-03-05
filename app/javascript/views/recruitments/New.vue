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
import { Recruitment } from '@models/recruitment'
import RecruitmentForm from '@components/recruitments/RecruitmentForm'

export default {
  name: 'RecruitmentsNew',
  components: { RecruitmentForm },
  data() {
    return {
      groups: ['red group', 'blue'],
      positions: ['ror', 'android'],
      statuses: ['fresh', 'accepted']
    }
  },
  computed: {
     ...mapGetters({
      recruitment: 'RecruitmentsModule/recruitment'
    })
  }
}
</script>
