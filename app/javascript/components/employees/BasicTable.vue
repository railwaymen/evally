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
            <td :style="{ padding: '0 5px' }">
              <v-tooltip right>
                <v-btn
                  @click="$emit('edit', props.item.id)"
                  slot="activator"
                  icon
                  flat
                >
                  <v-icon size="15">edit</v-icon>
                </v-btn>
                <span>Edit</span>
              </v-tooltip>
            </td>
            <td>
              <router-link :to="{ name: 'employee_path', params: { id: props.item.id }}">
                {{ props.item.fullname }}
              </router-link>
            </td>
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
  name: 'BasicTable',
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
          sortable: false,
          value: null,
        },
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
