<template>
  <v-layout row wrap>
    <v-flex xs4>
      <v-text-field
        v-model="search"
        append-icon="search"
        :label="$t('employees.table.search')"
      />
    </v-flex>

    <v-flex xs12>
      <div class="employees__table">
        <v-data-table
          :headers="headers"
          :items="employees.models"
          :search="search"
          :rows-per-page-items="perPageItems"
          :loading="loading"
        >
          <template #items="props">
            <td>{{ props.item.fullname }}</td>
            <td class="text-xs-center">
              <v-tooltip left>
                <template #activator="{ on }">
                  <span v-on="on">{{ props.item.hiredAt }}</span>
                </template>
                <span>{{ props.item.employmentTime }}</span>
              </v-tooltip>
            </td>
            <td class="text-xs-center">{{ props.item.group }}</td>
            <td class="text-xs-center">{{ props.item.position }}</td>
            <td class="text-xs-center">{{ props.item.positionSetAt }}</td>
            <td class="text-xs-center">{{ props.item.latestEvaluationDate }}</td>
          </template>
        </v-data-table>
      </div>
    </v-flex>
  </v-layout>
</template>

<script>
import { EmployeesList } from '@models/employee'

export default {
  name: 'EmployeesTable',
  props: {
    loading: {
      type: Boolean,
      required: true,
      default: false
    },
    employees: {
      type: EmployeesList,
      required: true,
      default: () => new EmployeesList()
    }
  },
  data() {
    return {
      search: '',
      headers: [
        {
          text: this.$t('employees.table.headers.employee_name'),
          value: 'fullname'
        },
        {
          text: this.$t('employees.table.headers.hired_at'),
          value: 'hired_at',
          align: 'center'
        },
        {
          text: this.$t('employees.table.headers.team'),
          value: 'group',
          align: 'center'
        },
        {
          text: this.$t('employees.table.headers.position'),
          value: 'position',
          align: 'center'
        },
        {
          text: this.$t('employees.table.headers.position_set_at'),
          value: 'position_set_at',
          align: 'center'
        },
        {
          text: this.$t('employees.table.headers.last_evaluation'),
          value: 'latest_evaluation_date',
          align: 'center'
        }
      ],
      perPageItems: [10, 30, { text: '$vuetify.dataIterator.rowsPerPageAll' , value: -1 }]
    }
  }
}
</script>
