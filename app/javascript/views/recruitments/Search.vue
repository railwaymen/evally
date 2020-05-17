<template>
  <div class="box">
    <search-by-skill-form
      :query="query"
      :skills="skills"
      @submit="searchRecruits"
      @reset="resetQuery"
    />

    <div class="search-results">
      <search-table
        :recruits="recruits"
        :loading="loading"
      />
    </div>
  </div>
</template>

<script>
import { mapActions, mapState } from 'vuex'

import { SearchBySkillQuery } from '@models/search_by_skill_query'

import SearchTable from '@components/recruitments/SearchTable'
import SearchBySkillForm from '@components/shared/SearchBySkillForm'

export default {
  name: 'RecruitmentsSearch',
  components: { SearchTable, SearchBySkillForm },
  methods: {
    ...mapActions('RecruitsSearchModule', [
      'fetchSkills',
      'searchRecruits'
    ]),
    resetQuery(query) {
      this.$store.commit('RecruitsSearchModule/SET_QUERY', query)
    }
  },
  computed: {
    ...mapState('RecruitsSearchModule', [
      'skills',
      'recruits',
      'query',
      'loading'
    ])
  },
  created() {
    this.fetchSkills()
  }
}
</script>
