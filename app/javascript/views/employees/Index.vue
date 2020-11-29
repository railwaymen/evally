<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">
        <h2>{{ $t('views.employees.index.title') }}</h2>
      </div>

      <div class="panel__nav">
        <v-btn
          color="primary"
          :to="{ name: 'employees_path' }"
          exact
          text
        >
          {{ $t('views.employees.index.nav.list') }}
        </v-btn>


        <v-btn
          color="primary"
          :to="{ name: 'employees_search_path' }"
          exact
          text
        >
          {{ $t('views.employees.index.nav.search') }}
        </v-btn>

        <v-btn
          v-if="employeePolicy.canSeeOverview"
          :to="{ name: 'employees_overview_path' }"
          color="primary"
          exact
          text
        >
          {{ $t('views.employees.index.nav.overview') }}
        </v-btn>

        <v-btn
          v-if="employeePolicy.canArchive"
          :to="{ name: 'employees_archived_path' }"
          color="primary"
          exact
          text
        >
          {{ $t('views.employees.index.nav.archived') }}
        </v-btn>
      </div>

      <div class="panel__actions">
        <v-tooltip
          v-if="$route.name === 'employees_path' && employeePolicy.canCreate"
          key="addNew"
          bottom
        >
          <template #activator="{ on }">
            <v-btn
              @click="openCreateForm"
              v-on="on"
              color="green"
              icon
            >
              <v-icon>mdi-plus</v-icon>
            </v-btn>
          </template>

          <span>{{ $t('shared.tooltips.addNew') }}</span>
        </v-tooltip>

        <template v-if="matchedRoute('employee_path')">
          <v-tooltip
            v-if="employeePolicy.canAddEvaluation"
            key="addEvaluation"
            bottom
          >
            <template #activator="{ on }">
              <v-btn
                @click="openNewEvaluationForm"
                :disabled="employee.isArchived"
                v-on="on"
                color="green"
                icon
              >
                <v-icon>mdi-clipboard-plus-outline</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.addEvaluation') }}</span>
          </v-tooltip>

          <v-tooltip
            v-if="employeePolicy.canEdit"
            key="edit"
            bottom
          >
            <template #activator="{ on }">
              <v-btn
                @click="openUpdateForm"
                :disabled="employee.isArchived"
                v-on="on"
                color="black"
                icon
              >
                <v-icon>mdi-pencil</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.edit') }}</span>
          </v-tooltip>

          <v-tooltip
            v-if="employeePolicy.canSeeCopyLink"
            key="copyLink"
            bottom
          >
            <template #activator="{ on }">
              <v-btn
                @click="copyLink"
                v-on="on"
                color="black"
                icon
              >
                <v-icon>mdi-link</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.copyLink') }}</span>
          </v-tooltip>

          <v-tooltip
            v-if="employee.isHired"
            key="archive"
            bottom
          >
            <template #activator="{ on }">
              <v-btn
                @click="openArchiveForm"
                v-on="on"
                color="orange"
                icon
              >
                <v-icon>mdi-account-cancel</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.archive') }}</span>
          </v-tooltip>

          <v-tooltip
            v-if="employee.isArchived"
            key="restore"
            bottom
          >
            <template #activator="{ on }">
              <v-btn
                @click="openRestoreConfirm"
                v-on="on"
                color="orange"
                icon
              >
                <v-icon>mdi-restore</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.restore') }}</span>
          </v-tooltip>

          <v-tooltip
            v-if="employeePolicy.canRemove"
            key="delete"
            bottom
          >
            <template #activator="{ on }">
              <v-btn
                @click="openDeleteConfirm"
                v-on="on"
                color="red"
                icon
              >
                <v-icon>mdi-delete-outline</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.delete') }}</span>
          </v-tooltip>
        </template>
      </div>
    </div>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <basic-table
          v-if="$route.name === 'employees_path'"
          :employees="employees"
          :employeePolicy="employeePolicy"
          :evaluators="evaluators"
          :groups="groups"
          :totalCount="totalCount"
          :loading="fetchLoading"
          @archive="openArchiveForm"
          @edit="openUpdateForm"
        />

        <router-view v-else :key="String($route.params.employeeId)" />
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapGetters, mapState } from 'vuex'
import { DialogsBus } from '@utils/dialogs_bus'

import { Employee } from '@models/employee'

import BasicTable from '@components/employees/BasicTable'
import DeleteConfirm from '@components/employees/DeleteConfirm'
import ArchiveForm from '@components/employees/ArchiveForm'
import RestoreConfirm from '@components/employees/RestoreConfirm'
import EmployeeForm from '@components/employees/EmployeeForm'
import CreateEvaluationForm from '@components/evaluations/CreateForm'

export default {
  name: 'EmployeesIndex',
  components: { BasicTable },
  methods: {
    openCreateForm() {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: EmployeeForm,
        maxWidth: 800,
        props: {
          employee: new Employee(),
          loading: this.formLoading
        }
      })
    },
    openUpdateForm(id) {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: EmployeeForm,
        maxWidth: 800,
        props: {
          employee: this.employees.findById(id) || this.employee,
          loading: this.formLoading
        }
      })
    },
    openDeleteConfirm() {
      DialogsBus.$emit('openConfirmDialog', {
        innerComponent: DeleteConfirm
      })
    },
    openArchiveForm(id) {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: ArchiveForm,
        props: {
          employee: this.employees.findById(id) || this.employee,
        }
      })
    },
    openRestoreConfirm() {
      DialogsBus.$emit('openConfirmDialog', {
        innerComponent: RestoreConfirm,
        props: {
          employee: this.employee
        }
      })
    },
    openNewEvaluationForm() {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: CreateEvaluationForm,
        props: {
          defaultEmployee: this.employee,
          templates: this.templates
        }
      })
    },
    copyLink() {
      this.$copyText(this.employee.publicLink, this.$el)
        .then(() => {
          this.flash({ success: this.$root.$t('messages.employees.show.copyLink') })
        })
    }
  },
  computed: {
    ...mapState('EmployeesModule', [
      'employees',
      'employee',
      'evaluators',
      'groups',
      'totalCount'
    ]),
    ...mapState('AuthenticationModule', [
      'user'
    ]),
    ...mapState('EvaluationEmployablesModule', [
      'templates'
    ]),
    ...mapGetters('EmployeesModule', [
      'fetchLoading',
      'formLoading',
      'employeePolicy'
    ])
  },
  destroyed() {
    this.$store.commit('EmployeesModule/RESET_STATE')
  }
}
</script>
