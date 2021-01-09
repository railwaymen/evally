<template>
  <div class="box">
    <server-side-table
      :composerClass="composerClass"
      :headers="headers"
      :items="employees.models"
      :loading="fetchLoading"
      :footer-props="{ 'items-per-page-options': [25, 50, 100] }"
      @change:options="fetchArchivedEmployees"
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

      <template #item.action="{ item }">
        <v-tooltip v-if="employeePolicy.canRestore" bottom>
          <template #activator="{ on }">
            <v-icon
              @click="openRestoreConfirm(item.id)"
              v-on="on"
              color="orange"
              class="mx-1"
              small
            >
              mdi-restore
            </v-icon>
          </template>

          <span>{{ $t('shared.tooltips.restore') }}</span>
        </v-tooltip>
      </template>

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

      <template #item.last_evaluation_on="{ item }">
        {{ item.lastEvaluationOn || '---' }}
      </template>

      <template #item.signature="{ item }">
        {{ item.signature || '---' }}
      </template>
    </server-side-table>
  </div>
</template>

<script>
import { mapGetters, mapState } from 'vuex'
import { DialogsBus } from '@utils/dialogs_bus'

import RestoreConfirm from '@components/employees/RestoreConfirm'
import ServerSideTable from '@components/shared/ServerSideTable'

import EmployeesTableComposer from '@utils/data_tables/employees_table_composer'

export default {
  name: 'EmployeesArchived',
  components: { ServerSideTable },
  data() {
    return {
      composerClass: EmployeesTableComposer,
      headers: [
        {
          sortable: false,
          value: 'action',
          align: 'right'
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
          text: this.$t('components.employees.table.cols.archivedOn'),
          value: 'archived_on'
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
          text: this.$t('components.employees.table.cols.lastEvaluationOn'),
          value: 'last_evaluation_on'
        },
        {
          text: this.$t('components.employees.table.cols.signature'),
          value: 'signature'
        }
      ]
    }
  },
  methods: {
    fetchArchivedEmployees(query) {
      this.$store.dispatch('EmployeesModule/fetchArchivedEmployees', query)
    },
    openRestoreConfirm(id) {
      DialogsBus.$emit('openConfirmDialog', {
        innerComponent: RestoreConfirm,
        props: {
          employee: this.employees.findById(id)
        }
      })
    }
  },
  computed: {
    ...mapState('EmployeesModule', [
      'employees'
    ]),
    ...mapGetters('EmployeesModule', [
      'employeePolicy',
      'fetchLoading'
    ])
  }
}
</script>
