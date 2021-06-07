<template>
  <v-layout row wrap>
    <v-flex v-if="recruitments.isEmpty && !loading" xs12>
      <div class="box mb-4">
        <h4 class="box__header">
          {{ $t('views.recruitments.index.noRecruitments') }}
        </h4>
      </div>
    </v-flex>

    <v-flex
      v-else
      v-for="recruitment in recruitments.models"
      :key="recruitment.id"
      xs12
    >
      <recruitment-row
        :recruitment="recruitment"
        :candidates-group="candidatesTree[recruitment.id]"
      />
    </v-flex>

    <v-flex v-if="totalPages > 1" xs12>
      <div class="box mb-2">
        <v-pagination v-model="page" :length="totalPages" :total-visible="9" class="my-4" />
      </div>
    </v-flex>
  </v-layout>
</template>

<script>
import { mapState } from 'vuex'

import RecruitmentRow from '@components/recruitments/RecruitmentRow'

export default {
  name: 'Recruitments',
  components: { RecruitmentRow },
  data() {
    return {
      page: Number(this.$route.query.page) || 1
    }
  },
  computed: {
    ...mapState('RecruitmentsModule', [
      'recruitments',
      'totalPages',
      'candidatesTree',
      'loading'
    ])
  },
  watch: {
    page: {
      handler(value) {
        this.$router.push({
          path: this.$route.path,
          query: { page: value }
        })
      }
    },
    $route: {
      immediate: true,
      handler(route) {
        this.$store.dispatch('RecruitmentsModule/fetchRecruitments', { page: route.query.page || 1 })
      }
    }
  },
  destroyed() {
    this.$store.commit('RecruitmentsModule/RESET_STATE')
  }
}
</script>
