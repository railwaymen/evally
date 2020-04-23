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
          v-if="user.isAdmin"
          :to="{ name: 'employees_overview_path' }"
          color="primary"
          exact
          text
        >
          {{ $t('views.employees.index.nav.overview') }}
        </v-btn>

        <v-btn
          v-if="user.isAdmin"
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
          v-if="$route.name === 'employees_path' && user.isAdmin"
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

        <template v-if="$route.name !== 'employees_path'">
          <v-tooltip bottom key="edit">
            <template #activator="{ on }">
              <v-btn
                @click="openUpdateForm"
                v-on="on"
                color="black"
                icon
              >
                <v-icon>mdi-pencil</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.edit') }}</span>
          </v-tooltip>

          <v-tooltip bottom key="copyLink">
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
            v-if="user.isAdmin"
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
            v-if="user.isAdmin"
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
          :loading="loading"
          :editable="user.isAdmin"
          @edit="openUpdateForm"
        />

        <router-view v-else />
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapState } from 'vuex'
import { DialogsBus } from '@utils/dialogs_bus'

import { Employee } from '@models/employee'

import BasicTable from '@components/employees/BasicTable'
import DeleteConfirm from '@components/employees/DeleteConfirm'
import ArchiveForm from '@components/employees/ArchiveForm'
import EmployeeForm from '@components/employees/EmployeeForm'

export default {
  name: 'EmployeesIndex',
  components: { BasicTable },
  methods: {
    openCreateForm() {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: EmployeeForm,
        maxWidth: 800,
        props: {
          employee: new Employee()
        }
      })
    },
    openUpdateForm(id) {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: EmployeeForm,
        maxWidth: 800,
        props: {
          employee: this.employees.findById(id) || this.employee
        }
      })
    },
    openDeleteConfirm() {
      DialogsBus.$emit('openConfirmDialog', {
        innerComponent: DeleteConfirm
      })
    },
    openArchiveForm() {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: ArchiveForm
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
      'loading'
    ]),
    ...mapState('AuthenticationModule', [
      'user'
    ])
  },
  watch: {
    $route: {
      immediate: true,
      handler(to) {
        if (to.name === 'employees_path') {
          this.$store.dispatch('EmployeesModule/fetchEmployees')
        }
      }
    }
  },
  destroyed() {
    this.$store.commit('EmployeesModule/RESET_STATE')
  }
}
</script>
