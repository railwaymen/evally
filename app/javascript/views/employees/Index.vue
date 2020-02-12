<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">
        <h2>{{ $t('views.employees.index.title') }}</h2>
      </div>

      <div class="panel__nav">
        <v-btn
          color="primary"
          @click="fetchData"
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
          color="primary"
          :to="{ name: 'employees_overview_path' }"
          exact
          text
        >
          {{ $t('views.employees.index.nav.overview') }}
        </v-btn>
      </div>

      <div class="panel__actions">
        <v-tooltip
          v-if="$route.name === 'employees_path'"
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
              <v-icon>add</v-icon>
            </v-btn>
          </template>

          <span>{{ $t('shared.tooltips.addNew') }}</span>
        </v-tooltip>

        <template v-if="$route.name === 'employee_path'">
          <v-tooltip bottom key="copyLink">
            <template #activator="{ on }">
              <v-btn
                @click="copyLink"
                v-on="on"
                color="black"
                icon
              >
                <v-icon>link</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.copyLink') }}</span>
          </v-tooltip>

          <v-tooltip bottom key="delete">
            <template #activator="{ on }">
              <v-btn
                @click="openDeleteConfirm"
                v-on="on"
                color="red"
                icon
              >
                <v-icon>delete</v-icon>
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
          @edit="openUpdateForm"
        />

        <router-view v-else />
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import { DialogsBus } from '@utils/dialogs_bus'

import { Employee } from '@models/employee'

import BasicTable from '@components/employees/BasicTable'
import DeleteConfirm from '@components/employees/DeleteConfirm'
import EmployeeForm from '@components/employees/EmployeeForm'

import { pluckUniq } from '@utils/helpers'

export default {
  name: 'EmployeesIndex',
  components: { BasicTable },
  methods: {
    openCreateForm() {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: EmployeeForm,
        maxWidth: 800,
        props: {
          positions: this.positions,
          groups: this.groups,
          employee: new Employee()
        }
      })
    },
    openUpdateForm(id) {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: EmployeeForm,
        maxWidth: 800,
        props: {
          positions: this.positions,
          groups: this.groups,
          employee: this.employees.findById(id)
        }
      })
    },
    openDeleteConfirm() {
      DialogsBus.$emit('openConfirmDialog', {
        innerComponent: DeleteConfirm
      })
    },
    copyLink() {
      this.$copyText(this.employee.publicLink, this.$el)
        .then(() => {
          this.flash({ success: this.$root.$t('messages.employees.show.copyLink') })
        })
    },
    ...mapActions({
      fetchData: 'EmployeesModule/index'
    })
  },
  computed: {
    positions() {
      return pluckUniq(this.employees.models, 'position')
    },
    groups() {
      return pluckUniq(this.employees.models, 'group')
    },
    ...mapGetters({
      employees: 'EmployeesModule/employees',
      employee: 'EmployeesModule/employee',
      loading: 'EmployeesModule/loading',
    })
  },
  created() {
    this.fetchData()
  }
}
</script>
