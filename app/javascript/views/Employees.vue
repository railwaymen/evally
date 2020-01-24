<template>
  <section class="panel">
    <div class="header">
      <div class="header__name">
        <h2>{{ $t('employees.title') }}</h2>
      </div>

      <div class="header__nav">
        <v-btn
          color="primary"
          :to="{ name: 'employees_path' }"
          exact
          flat
        >
          List
        </v-btn>


        <v-btn
          color="primary"
          :to="{ name: 'employees_search_path' }"
          exact
          flat
        >
          Search
        </v-btn>

        <v-btn
          color="primary"
          :to="{ name: 'employees_overview_path' }"
          exact
          flat
        >
          Overview
        </v-btn>
      </div>

      <div class="header__actions">
        <v-tooltip bottom>
          <v-btn
            color="green"
            slot="activator"
            icon
            flat
          >
            <v-icon>add</v-icon>
          </v-btn>
          <span>{{ $t('employees.buttons.add_new') }}</span>
        </v-tooltip>
      </div>
    </div>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <div class="box box--with-content">
          <employees-table
            v-if="$route.name === 'employees_path'"
            :employees="employees"
            :loading="loading"
          />

          <router-view v-else />
        </div>
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'

import EmployeesTable from '@components/employees/EmployeesTable'

export default {
  name: 'Employees',
  components: { EmployeesTable },
  methods: {
    ...mapActions({
      fetchData: 'EmployeesModule/index'
    })
  },
  computed: {
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
