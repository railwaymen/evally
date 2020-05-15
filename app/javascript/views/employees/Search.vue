<template>
  <div class="box">
    <search-by-skill-form
      :query="query"
      :skills="skills"
      @submit="searchEmployees"
      @reset="resetQuery"
    />

    <div class="search-results">
      <search-table
        :employees="employees"
        :loading="loading"
      />
    </div>
  </div>
</template>

<script>
import { mapActions, mapState } from 'vuex'

import SearchBySkillForm from '@components/shared/SearchBySkillForm'
import SearchTable from '@components/employees/SearchTable'

export default {
  name: 'EmployeesSearch',
  components: { SearchBySkillForm, SearchTable },
  methods: {
    ...mapActions('EmployeesSearchModule', [
      'searchEmployees',
      'fetchSkills'
    ]),
    resetQuery() {
      this.$store.commit('EmployeesSearchModule/SET_QUERY', query)
    }
  },
  computed: {
    ...mapState('EmployeesSearchModule', [
      'skills',
      'query',
      'employees',
      'loading'
    ])
  },
  created() {
    this.fetchSkills()
  }
}
</script>
