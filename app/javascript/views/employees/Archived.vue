<template>
  <archived-table
    :employees="employees"
    :loading="fetchLoading"
  />
</template>

<script>
import { mapGetters, mapState } from 'vuex'

import ArchivedTable from '@components/employees/ArchivedTable'

export default {
  name: 'EmployeesArchived',
  components: { ArchivedTable },
  computed: {
    ...mapState('EmployeesModule', [
      'employees'
    ]),
    ...mapGetters('EmployeesModule', [
      'fetchLoading'
    ])
  },
  created() {
    this.$store.dispatch('EmployeesModule/fetchArchivedEmployees')
  }
}
</script>
