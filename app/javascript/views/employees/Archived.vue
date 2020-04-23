<template>
  <section>
    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <archived-table
          :employees="employees"
          :loading="fetchLoading"
        />
      </v-container>
    </div>
  </section>
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
