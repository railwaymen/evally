<template>
  <v-data-table
    :headers="headers"
    :items="employees.models"
    :loading="loading"
    :rows-per-page-items="perPageItems"
  >
    <template #items="props">
      <td>
        <router-link :to="{ name: 'employee_path', params: { employeeId: props.item.id }}">
          {{ props.item.fullname }}
        </router-link>
      </td>
      <td>
        <v-rating
          v-if="props.item.skill.group === 'rating'"
          :value="props.item.skill.value"
          length="3"
          readonly
        />

        <v-chip v-if="props.item.skill.group === 'bool'" text-color="black" disabled>
          {{ props.item.skill.value ? $t('components.employees.searchTable.labels.yes') : $t('components.employees.searchTable.labels.no') }}
        </v-chip>
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
          value: 'skill.value'
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
          text: this.$t('components.employees.searchTable.cols.positionSetAt'),
          value: 'position_set_at',
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
