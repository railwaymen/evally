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

      <v-flex xs12 lg4>
        <v-select
          v-model="filters.group"
          :items="groups"
          :label="$t('components.employees.table.groupFilter')"
          clearable
          chips
          solo
        />
      </v-flex>

      <v-flex xs12 lg4>
        <v-select
          v-model="filters.evaluatorId"
          :items="evaluators.models"
          :label="$t('components.employees.table.evaluatorFilter')"
          item-value="id"
          item-text="fullname"
          clearable
          chips
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
          <template #item.action="{ item }">
            <v-tooltip v-if="employeePolicy.canArchive" bottom>
              <template #activator="{ on }">
                <v-icon
                  @click="$emit('archive', item.id)"
                  v-on="on"
                  color="orange"
                  class="mx-1"
                  small
                >
                  mdi-account-cancel
                </v-icon>
              </template>

              <span>{{ $t('shared.tooltips.archive') }}</span>
            </v-tooltip>

            <v-tooltip v-if="employeePolicy.canEdit" bottom>
              <template #activator="{ on }">
                <v-icon
                  @click="$emit('edit', item.id)"
                  v-on="on"
                  class="mx-1"
                  small
                >
                  mdi-pencil
                </v-icon>
              </template>

              <span>{{ $t('shared.tooltips.edit') }}</span>
            </v-tooltip>
          </template>

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

          <template #item.position_set_on="{ item }">
            {{ item.positionSetOn }}
          </template>

          <template #item.evaluator_fullname="{ item }">
            {{ item.evaluator_fullname || '---' }}
          </template>

          <template #item.latest_evaluation_date="{ item }">
            {{ item.latestEvaluationDate }}
          </template>

          <template #item.next_evaluation_on="{ item }">
            {{ item.nextEvaluationOn }}
          </template>
        </v-data-table>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import EmployeePolicy from '@policies/employee_policy'

import { EmployeesList } from '@models/employee'
import { UsersList } from '@models/user'

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
    },
    employeePolicy: {
      type: EmployeePolicy,
      required: true,
      default: () => new EmployeePolicy()
    },
    evaluators: {
      type: UsersList,
      required: true,
      default: () => new UsersList()
    },
    groups: {
      type: Array,
      required: true,
      default: () => []
    }
  },
  data() {
    return {
      search: '',
      filters: {
        group: '',
        evaluatorId: null
      },
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
          text: this.$t('components.employees.table.cols.positionSetOn'),
          value: 'position_set_on'
        },
        {
          text: this.$t('components.employees.table.cols.currentEvaluator'),
          value: 'evaluator_fullname'
        },
        {
          text: this.$t('components.employees.table.cols.latestEvaluationAt'),
          value: 'latest_evaluation_date'
        },
        {
          text: this.$t('components.employees.table.cols.nextEvaluationOn'),
          value: 'next_evaluation_on'
        }
      ]
    }
  },
  watch: {
    filters: {
      deep: true,
      handler(filters) {
        const payload = {
          group: filters.group || '',
          evaluator_id: filters.evaluatorId || ''
        }

        this.$store.dispatch('EmployeesModule/filterEmployees', payload)
      }
    }
  }
}
</script>
