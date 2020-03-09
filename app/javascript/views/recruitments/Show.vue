<template>
  <v-layout row wrap class="align-stretch">
    <v-flex xs10 offset-xs1 lg3 offset-lg0>
      <recruitments-sidebar
        :recruitDocument="recruitDocument"
      />
    </v-flex>

    <v-flex xs12 lg9>
      <v-layout row wrap>
        <v-flex xs12 lg6>
          Evaluation
        </v-flex>

        <v-flex xs12 lg6>
          Comments
        </v-flex>
      </v-layout>
    </v-flex>
  </v-layout>
 </template>

<script>
import { mapGetters } from 'vuex'
import RecruitmentsSidebar from '@components/recruitments/RecruitmentsSidebar'

export default {
  name: 'RecruitmentsShow',
  components: { RecruitmentsSidebar },
  computed: {
     ...mapGetters({
      recruitDocument: 'RecruitmentsModule/recruitDocument'
    })
  },
  created() {
    this.$store.dispatch('RecruitmentsModule/show', this.$route.params.id)
  },
}
</script>
