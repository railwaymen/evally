<template>
  <div class="employees" style="background: white;">
    <v-layout row wrap>
      <v-flex xs4>
        <v-text-field
          v-model="search"
          append-icon="search"
          :label="$t('employees.sidebar.search')"
          data-cy="employees-search"
        />
      </v-flex>

      <v-flex xs8>
        <div class="employees__actions">
          <v-btn color="green" flat>New employee</v-btn>
        </div>
      </v-flex>

      <v-flex xs12>
        <div class="employees__table">
          <v-data-table
            :headers="headers"
            :items="employees.models"
            :search="search"
          >
            <template v-slot:items="props">
              <td>{{ props.item.fullname() }}</td>
              <td class="text-xs-center">{{ props.item.position }}</td>
              <td class="text-xs-center">{{ props.item.hired_at | moment("MMMM YYYY") }}</td>
              <td class="text-xs-center">{{ props.item.evaluation.completed_at | moment("MMM DD, YYYY") }}</td>

              <td class="text-xs-right">
                <v-tooltip bottom>
                  <v-btn slot="activator" color="grey" flat icon>
                    <v-icon>person</v-icon>
                  </v-btn>
                  <span>Show profile</span>
                </v-tooltip>

                <v-tooltip bottom>
                  <v-btn slot="activator" color="grey" flat icon>
                    <v-icon>edit</v-icon>
                  </v-btn>
                  <span>Edit</span>
                </v-tooltip>

                <v-tooltip bottom>
                  <v-btn slot="activator" color="red lighten-3" flat icon>
                    <v-icon>delete</v-icon>
                  </v-btn>
                  <span>Delete</span>
                </v-tooltip>
              </td>
            </template>
          </v-data-table>
        </div>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'EmployeesTable',
  data() {
    return {
      search: '',
      headers: [
        { text: 'Employee name', value: 'last_name' },
        { text: 'Position', value: 'position', align: 'center' },
        { text: 'Hired', value: 'hired_at', align: 'center' },
        { text: 'Last evaluation', value: 'evaluation.completed_at', align: 'center' },
        { text: '', sortable: false, width: '220' }
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
