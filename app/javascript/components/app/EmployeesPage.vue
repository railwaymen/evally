<template>
  <section class="panel">
    <v-layout row>
      <v-flex xs6>
        <h2 class="panel__heading">Employees</h2>
      </v-flex>

      <v-flex>
        <div class="panel__action-bar">
          <v-btn color="green" flat>
            <v-icon>add</v-icon> New
          </v-btn>
          <v-btn flat>
            <v-icon>list</v-icon> List evaluations
          </v-btn>
          <v-btn flat>
            <v-icon>edit</v-icon> Edit
          </v-btn>
          <v-btn color="red" flat>
            <v-icon>delete</v-icon> Delete
          </v-btn>
        </div>
      </v-flex>
    </v-layout>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout row>
          <v-flex xs3>
            <search-box></search-box>
          </v-flex>

          <v-flex xs9>
            <employee-card></employee-card>
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import EmployeeCard from './employees/EmployeeCard'
import SearchBox from './employees/SearchBox'

export default {
  components: { EmployeeCard, SearchBox }
}
</script>
