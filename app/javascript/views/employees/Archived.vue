<template>
  <section>
    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <archived-table
          :employees="employees"
          :loading="loading"
        />
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapGetters } from 'vuex'

import ArchivedTable from '@components/employees/ArchivedTable'

export default {
  name: 'EmployeesArchived',
  components: { ArchivedTable },
  computed: {
    ...mapGetters({
      employees: 'EmployeesModule/employees',
      loading: 'EmployeesModule/loading',
    })
  },
  created() {
    this.$store.dispatch('EmployeesModule/fetchArchivedEmployees')
  }
}
</script>
