<template>
  <section>
    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <basic-table
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
import BasicTable from '@components/employees/BasicTable'

export default {
  name: 'EmployeesArchived',
  components: { BasicTable },
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
