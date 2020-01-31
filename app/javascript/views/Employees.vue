<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">
        <h2>{{ $t('views.employees.title') }}</h2>
      </div>

      <div class="panel__nav">
        <v-btn
          color="primary"
          :to="{ name: 'employees_path' }"
          exact
          flat
        >
          {{ $t('views.employees.nav.list') }}
        </v-btn>


        <v-btn
          color="primary"
          :to="{ name: 'employees_search_path' }"
          exact
          flat
        >
          {{ $t('views.employees.nav.search') }}
        </v-btn>

        <v-btn
          color="primary"
          :to="{ name: 'employees_overview_path' }"
          exact
          flat
        >
          {{ $t('views.employees.nav.overview') }}
        </v-btn>
      </div>

      <div class="panel__actions">
        <v-tooltip bottom>
          <v-btn
            @click="openCreateForm"
            color="green"
            slot="activator"
            icon
            flat
          >
            <v-icon>add</v-icon>
          </v-btn>
          <span>{{ $t('shared.tooltips.addNew') }}</span>
        </v-tooltip>
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
import CreateForm from '@components/employees/CreateForm'

import { pluckUniq } from '@utils/helpers'

export default {
  name: 'Employees',
  components: { BasicTable },
  methods: {
    openCreateForm() {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: CreateForm,
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
        innerComponent: CreateForm,
        maxWidth: 800,
        props: {
          positions: this.positions,
          groups: this.groups,
          employee: this.employees.findById(id)
        }
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
      loading: 'EmployeesModule/loading',
    })
  },
  created() {
    this.fetchData()
  }
}
</script>
