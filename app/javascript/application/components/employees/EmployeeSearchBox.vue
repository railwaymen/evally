<template>
  <div class="search-box">
    <div class="search-box__input">
      <v-text-field
        v-model="search"
        append-icon="search"
        label="Search by name"
        box
      ></v-text-field>
    </div>

    <div class="search-box__list">
      <v-list two-line subheader>
        <v-subheader>List of employees</v-subheader>

        <v-list-tile v-for="employee in filteredEmployees" :key="employee.id" @click="showEvaluation(employee.id)">
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
            <v-list-tile-title>There are no employees to show</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
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
    showEvaluation(employee_id) {
      this.$store.commit('EmployeesStore/one', employee_id)
      this.$store.commit('EvaluationsStore/oneCompleted', employee_id)
    }
  },
  computed: {
    ...mapGetters({
      employees: 'EmployeesStore/employees'
    }),
    
    filteredEmployees() {
      let hired = this.employees.models.filter(employee => employee.state === 'hired')

      if (this.search.length > 0) {
        return hired.filter(employee => {
          let fullname = employee.fullname()
          return fullname.toLowerCase().indexOf(this.search.toLowerCase()) > -1
        })
      }

      return hired
    }
  }
}
</script>
