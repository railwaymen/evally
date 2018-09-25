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

        <v-list-tile v-for="employee in filterableEmployees" :key="employee.id" @click="selectEmployee">
          <v-list-tile-action>
            <v-icon>person_outline</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>{{ `${employee.first_name} ${employee.last_name}` }}</v-list-tile-title>
            <v-list-tile-sub-title>{{ employee.position }}</v-list-tile-sub-title>
          </v-list-tile-content>
        </v-list-tile>

        <v-list-tile v-if="filterableEmployees.length == 0">
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
  name: 'SearchBox',
  data () {
    return {
      search: ''
    }
  },
  methods: {
    selectEmployee() {
      console.log('Hahaha!')
    }
  },
  computed: {
    ...mapGetters({
      employees: 'EmployeesStore/employees',
      status: 'EmployeesStore/status'
    }),
    filterableEmployees() {
      if (this.search.length > 0) {
        return this.employees.models.filter(employee => {
          let fullname = `${employee.first_name} ${employee.last_name}`
          return fullname.toLowerCase().indexOf(this.search.toLowerCase()) > -1
        })
      } else {
        return this.employees.models
      }
    }
  },
  mounted() {
    this.$store.dispatch('EmployeesStore/index')
      .catch( error => {
        this.flash({ error: 'Employees cannot be loaded due to some error: ' + error.message })
      })
  }

}
</script>
