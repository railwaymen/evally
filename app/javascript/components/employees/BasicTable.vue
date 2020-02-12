<template>
  <div class="box">
    <v-layout row wrap>
      <v-flex xs6>
        <v-text-field
          v-model="search"
          append-icon="search"
          :label="$t('components.employees.table.search')"
          box
        />
      </v-flex>

      <v-flex xs12>
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
                <template #activator="{ on }">
                  <v-btn
                    @click="$emit('edit', props.item.id)"
                    v-on="on"
                    icon
                    flat
                  >
                    <v-icon size="15">edit</v-icon>
                  </v-btn>
                </template>

                <span>{{ $t('shared.tooltips.edit') }}</span>
              </v-tooltip>
            </td>
            <td>
              <router-link :to="{ name: 'employee_path', params: { employeeId: props.item.id }}">
                {{ props.item.fullname }}
              </router-link>
            </td>
            <td class="text-center">
              <v-tooltip left>
                <template #activator="{ on }">
                  <span v-on="on">{{ props.item.hiredOn }}</span>
                </template>
                <span>{{ props.item.employmentTime }}</span>
              </v-tooltip>
            </td>
            <td class="text-center">{{ props.item.group }}</td>
            <td class="text-center">{{ props.item.position }}</td>
            <td class="text-center">{{ props.item.positionSetAt }}</td>
            <td class="text-center">{{ props.item.latestEvaluationDate }}</td>
          </template>
        </v-data-table>
      </v-flex>
    </v-layout>
  </div>
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
          text: this.$t('components.employees.table.cols.name'),
          value: 'fullname'
        },
        {
          text: this.$t('components.employees.table.cols.hiredOn'),
          value: 'hired_on',
          align: 'center'
        },
        {
          text: this.$t('components.employees.table.cols.group'),
          value: 'group',
          align: 'center'
        },
        {
          text: this.$t('components.employees.table.cols.position'),
          value: 'position',
          align: 'center'
        },
        {
          text: this.$t('components.employees.table.cols.positionSetAt'),
          value: 'position_set_at',
          align: 'center'
        },
        {
          text: this.$t('components.employees.table.cols.latestEvaluationAt'),
          value: 'latest_evaluation_date',
          align: 'center'
        }
      ],
      perPageItems: [10, 30, { text: '$vuetify.dataIterator.rowsPerPageAll' , value: -1 }]
    }
  }
}
</script>
