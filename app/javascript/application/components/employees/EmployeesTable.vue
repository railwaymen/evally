<template>
  <v-layout row wrap>
    <v-flex xs4>
      <v-text-field
        v-model="search"
        append-icon="search"
        :label="$t('employees.sidebar.search')"
        data-cy="employees-search"
        box
      ></v-text-field>
    </v-flex>

    <v-flex xs12>
      <div class="employees-table pa-4" style="background: white;">
        <v-data-table
          :headers="headers"
          :items="employees.models"
          :search="search"
        >
          <template v-slot:items="props">
            <td>{{ props.item.fullname() }}</td>
            <td>{{ props.item.position }}</td>
            <td>{{ props.item.hired_at }}</td>
          </template>
        </v-data-table>
      </div>
    </v-flex>
  </v-layout>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'EmployeesTable',
  data() {
    return {
      search: '',
      headers: [
        { text: 'Employee name', value: 'name' },
        { text: 'Position', value: 'position' },
        { text: 'Hired at', value: 'hired_at' }
      ]
    }
  },
  computed: {
    ...mapGetters({
      employees: 'EmployeesStore/employees',
      status: 'EmployeesStore/status'
    }),
  }
}
</script>
