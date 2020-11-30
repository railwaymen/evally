<template>
  <div class="box">
    <server-side-table
      :composerClass="composerClass"
      :headers="headers"
      :items="employees.models"
      :footer-props="{ 'items-per-page-options': [25, 50, 100, -1] }"
      :server-items-length="totalCount"
      :loading="loading"
      @change:options="fetchEmployees"
    >
      <template #search="{ options, searchBy }">
        <v-flex xs12 lg4>
          <v-text-field
            :value="options.search"
            @input="searchBy"
            append-icon="mdi-magnify"
            :label="$t('components.employees.table.search')"
            solo
          />
        </v-flex>
      </template>

      <template #filters="{ options }">
        <v-flex xs12 lg4>
          <v-select
            v-model="options.group"
            :items="groups"
            :label="$t('components.employees.table.groupFilter')"
            clearable
            chips
            solo
          />
        </v-flex>

        <v-flex xs12 lg4>
          <v-select
            v-model="options.evaluatorId"
            :items="evaluators.models"
            :label="$t('components.employees.table.evaluatorFilter')"
            item-value="id"
            item-text="fullname"
            clearable
            chips
            solo
          />
        </v-flex>
      </template>

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

      <template #item.last_name="{ item }">
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

      <template #item.last_evaluation_on="{ item }">
        {{ item.lastEvaluationOn || '---' }}
      </template>

      <template #item.next_evaluation_on="{ item }">
        {{ item.nextEvaluationText }}
      </template>

      <template #item.signature="{ item }">
        {{ item.signature || '---' }}
      </template>
    </server-side-table>
  </div>
</template>

<script>
import EmployeePolicy from '@policies/employee_policy'

import { EmployeesList } from '@models/employee'
import { UsersList } from '@models/user'

import ServerSideTable from '@components/shared/ServerSideTable'

import EmployeesTableComposer from '@utils/data_tables/employees_table_composer'

export default {
  name: 'BasicTable',
  components: { ServerSideTable },
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
    },
    totalCount: {
      type: Number,
      required: true,
      default: 0
    }
  },
  data() {
    return {
      composerClass: EmployeesTableComposer,
      headers: [
        {
          sortable: false,
          value: 'action',
          width: 90,
          align: 'right'
        },
        {
          value: 'fullname',
          align: ' d-none'
        },
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
          text: this.$t('components.employees.table.cols.positionSetOn'),
          value: 'position_set_on'
        },
        {
          text: this.$t('components.employees.table.cols.currentEvaluator'),
          value: 'evaluator_fullname',
          sortable: false
        },
        {
          text: this.$t('components.employees.table.cols.lastEvaluationOn'),
          value: 'last_evaluation_on'
        },
        {
          text: this.$t('components.employees.table.cols.nextEvaluationOn'),
          value: 'next_evaluation_on'
        },
        {
          text: this.$t('components.employees.table.cols.signature'),
          value: 'signature'
        }
      ]
    }
  },
  methods: {
    fetchEmployees(query) {
      this.$store.dispatch('EmployeesModule/filterEmployees', query)
    }
  }
}
</script>
