<template>
  <div class="box">
    <v-layout row wrap>
      <v-flex xs12 lg6>
        <v-text-field
          v-model="search"
          append-icon="mdi-magnify"
          :label="$t('components.employees.table.search')"
          filled
        />
      </v-flex>

      <v-flex xs12>
        <v-data-table
          :headers="headers"
          :items="employees.models"
          :search="search"
          :loading="loading"
        >
          <template #item.fullname="{ item }">
            <router-link :to="{ name: 'employee_path', params: { employeeId: item.id }}">
              {{ item.fullname }}
            </router-link>
          </template>

          <template #item.hired_on="{ item }">
            <v-tooltip left>
              <template #activator="{ on }">
                <span v-on="on">{{ item.hiredOn }}</span>
              </template>
              <span>{{ item.employmentTime }}</span>
            </v-tooltip>
          </template>

        </v-data-table>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { EmployeesList } from '@models/employee'

export default {
  name: 'ArchivedTable',
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
    },
    editable: {
      type: Boolean,
      required: true,
      default: false
    }
  },
  data() {
    return {
      search: '',
      headers: [
        {
          sortable: false,
          value: 'action',
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
          text: this.$t('components.employees.table.cols.archivedOn'),
          value: 'archived_on',
          align: 'center'
        }
      ]
    }
  }
}
</script>
