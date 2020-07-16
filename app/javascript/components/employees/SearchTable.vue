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
        background-color="grey"
        length="3"
        readonly
      />

      <v-chip
        v-if="item.skill.group === 'bool'"
        :color="item.skill.value ? 'primary' : ''"
        label
      >
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

    <template #item.evaluator_fullname="{ item }">
      {{ item.evaluator_fullname || '---' }}
    </template>

    <template #item.last_evaluation_on="{ item }">
      {{ item.lastEvaluationOn }}
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
          value: 'hired_on'
        },
        {
          text: this.$t('components.employees.searchTable.cols.group'),
          value: 'group'
        },
        {
          text: this.$t('components.employees.searchTable.cols.position'),
          value: 'position'
        },
        {
          text: this.$t('components.employees.searchTable.cols.positionSetOn'),
          value: 'position_set_on'
        },
        {
          text: this.$t('components.employees.searchTable.cols.currentEvaluator'),
          value: 'evaluator_fullname'
        },
        {
          text: this.$t('components.employees.searchTable.cols.lastEvaluationOn'),
          value: 'last_evaluation_on'
        }
      ]
    }
  }
}
</script>
