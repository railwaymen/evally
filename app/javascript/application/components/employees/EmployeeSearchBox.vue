<template>
  <div class="search-box">
    <div class="search-box__input">
      <v-text-field
        v-model="search"
        append-icon="search"
        :label="$t('employees.sidebar.search')"
        data-cy="employees-search"
        box
      ></v-text-field>
    </div>

    <div class="search-box__list" data-cy="employees-list">
      <v-list two-line subheader>
        <v-subheader>{{ $t('employees.sidebar.subheader') }}</v-subheader>

        <div v-if="isLoading" class="box__loader">
          <v-progress-circular :size="30" :width="3" color="primary" indeterminate></v-progress-circular>
        </div>

        <template v-else>
          <v-list-tile v-for="employee in filteredEmployees" :key="employee.id" @click="pickEmployee(employee.id)" data-cy="employee-list-item">
            <v-list-tile-action>
              <v-icon>person_outline</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title>{{ employee.fullname() }}</v-list-tile-title>
              <v-list-tile-sub-title>{{ employee.position }}</v-list-tile-sub-title>
            </v-list-tile-content>
          </v-list-tile>

          <v-list-tile v-if="filteredEmployees.length == 0">
            <v-list-tile-action>
              <v-icon>error_outline</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title>{{ $t('employees.sidebar.no_items') }}</v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
        </template>
      </v-list>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'EmployeeSearchBox',
  data () {
    return {
      search: ''
    }
  },
  methods: {
    pickEmployee(id) {
      this.$store.commit('EmployeesStore/pick', id)
      // this.$store.commit('EvaluationsStore/oneCompleted', employee_id)
    }
  },
  computed: {
    ...mapGetters({
      employees: 'EmployeesStore/employees',
      status: 'EmployeesStore/status'
    }),
    
    filteredEmployees() {
      let output = []

      if (this.search.length > 0) {
        output = this.employees.models.filter(employee => {
          return employee.fullname().toLowerCase().indexOf(this.search.toLowerCase()) > -1
        })
      } else {
        output = this.employees.models
      }

      return output.sort((a, b) => a.last_name.localeCompare(b.last_name))
    }
  }
}
</script>
