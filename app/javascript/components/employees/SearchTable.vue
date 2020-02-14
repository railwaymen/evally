<template>
  <v-data-table
    :headers="headers"
    :items="employees.models"
    :loading="loading"
  >
    <template #item.fullname="{ item }">
      <router-link :to="{ name: 'employee_path', params: { employeeId: item.id }}">
        {{ item.fullname }}
      </router-link>
    </template>

    <template #item.skill_value="{ item }">
      <v-rating
        v-if="item.skill.group === 'rating'"
        :value="item.skill.value"
        length="3"
        readonly
      />

      <v-chip v-if="item.skill.group === 'bool'" text-color="black" disabled>
        {{ item.skill.value ? $t('components.employees.searchTable.labels.yes') : $t('components.employees.searchTable.labels.no') }}
      </v-chip>
    </template>

    <template #item.hired_on="{ item }">
      <v-tooltip left>
        <template #activator="{ on }">
          <span v-on="on">{{ item.hiredOn }}</span>
        </template>
        <span>{{ item.employmentTime }}</span>
      </v-tooltip>
    </template>

    <template #item.position_set_on="{ item }">
      {{ item.positionSetOn }}
    </template>

    <template #item.latest_evaluation_date="{ item }">
      {{ item.latestEvaluationDate }}
    </template>
  </v-data-table>
</template>

<script>
import { EmployeesList } from '@models/employee'

export default {
  name: 'SearchTable',
  props: {
    employees: {
      type: EmployeesList,
      required: true,
      default: () => new EmployeesList()
    },
    loading: {
      type: Boolean,
      requied: true,
      default: false
    }
  },
  data() {
    return {
      headers: [
        {
          text: this.$t('components.employees.searchTable.cols.name'),
          value: 'fullname'
        },
        {
          text: this.$t('components.employees.searchTable.cols.skill'),
          value: 'skill_value'
        },
        {
          text: this.$t('components.employees.searchTable.cols.hiredOn'),
          value: 'hired_on',
          align: 'center'
        },
        {
          text: this.$t('components.employees.searchTable.cols.group'),
          value: 'group',
          align: 'center'
        },
        {
          text: this.$t('components.employees.searchTable.cols.position'),
          value: 'position',
          align: 'center'
        },
        {
          text: this.$t('components.employees.searchTable.cols.positionSetOn'),
          value: 'position_set_on',
          align: 'center'
        },
        {
          text: this.$t('components.employees.searchTable.cols.latestEvaluationAt'),
          value: 'latest_evaluation_date',
          align: 'center'
        }
      ],
      perPageItems: [10, 30, { text: '$vuetify.dataIterator.rowsPerPageAll' , value: -1 }]
    }
  }
}
</script>
