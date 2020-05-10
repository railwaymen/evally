<template>
  <div class="box">
    <search-by-skill-form
      :query="query"
      :skills="skills"
      @submit="searchRecruits"
      @reset="resetQuery"
    />

    <div class="search-results">

    </div>
  </div>
</template>

<script>
import { mapActions, mapState } from 'vuex'

import { SearchBySkillQuery } from '@models/search_by_skill_query'

import SearchBySkillForm from '@components/shared/SearchBySkillForm'

export default {
  name: 'RecruitmentsSearch',
  components: { SearchBySkillForm },
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
      'query',
      'loading'
    ])
  },
  created() {
    this.fetchSkills()
  }
}
</script>
