<template>
  <div class="box">
    <v-layout row wrap>
      <v-flex xs12 lg4>
        <v-text-field
          v-model="search"
          append-icon="mdi-magnify"
          :label="$t('components.employees.table.search')"
          solo
        />
      </v-flex>

      <v-flex xs12>
        <v-data-table
          :headers="headers"
          :items="employees.models"
          :search="search"
          :loading="loading"
          :footer-props="{ 'items-per-page-options': [25, 50, 100, -1] }"
        >
          <template #item.last_name="{ item }">
            <router-link :to="{ name: 'employee_path', params: { employeeId: item.id }}">
              {{ item.fullname }}
            </router-link>
          </template>

          <template #item.hired_on="{ item }">
            {{ item.hiredOn }}
          </template>

          <template #item.archived_on="{ item }">
            {{ item.archivedOn }}
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
    }
  },
  data() {
    return {
      search: '',
      headers: [
        {
          text: this.$t('components.employees.table.cols.name'),
          value: 'last_name'
        },
        {
          text: this.$t('components.employees.table.cols.hiredOn'),
          value: 'hired_on'
        },
        {
          text: this.$t('components.employees.table.cols.group'),
          value: 'group'
        },
        {
          text: this.$t('components.employees.table.cols.position'),
          value: 'position'
        },
        {
          text: this.$t('components.employees.table.cols.archivedOn'),
          value: 'archived_on'
        }
      ]
    }
  }
}
</script>
