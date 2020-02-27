<template>
  <div class="box">
    <v-layout row wrap>
      <v-flex xs12 lg6>

      </v-flex>

      <v-flex xs12>
        <v-data-table
          :headers="headers"
          :items="employees.models"
          :search="search"
          :loading="loading"
        >
        </v-data-table>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { EmployeesList } from '@models/employee'
import i18n from '@locales/i18n'

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
          text: i18n.t('components.employees.table.cols.name'),
          value: 'fullname'
        },
        {
          text: i18n.t('components.employees.table.cols.hiredOn'),
          value: 'hired_on',
          align: 'center'
        },
        {
          text: i18n.t('components.employees.table.cols.group'),
          value: 'group',
          align: 'center'
        },
        {
          text: i18n.t('components.employees.table.cols.position'),
          value: 'position',
          align: 'center'
        },
        {
          text: i18n.t('components.employees.table.cols.archivedOn'),
          value: 'archived_on',
          align: 'center'
        }
      ]
    }
  }
}
</script>
