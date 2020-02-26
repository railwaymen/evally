<template>
  <section>
    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <archived-table
          :employees="employees"
          :loading="loading"
          :editable="user.isAdmin"
        />
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import ArchivedTable from '@components/employees/ArchivedTable'

export default {
  name: 'EmployeesArchived',
  components: { ArchivedTable },
  methods: {
    ...mapActions({
      fetchData: 'EmployeesModule/archived'
    })
  },
  computed: {
    ...mapGetters({
        user: 'AuthenticationModule/user',
        employees: 'EmployeesModule/employees',
        loading: 'EmployeesModule/loading',
    })
  },
  created() {
    this.fetchData()
  }

}
</script>
