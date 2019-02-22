<template>
  <section class="panel">
    <v-layout row>
      <v-flex xs12>
        <h2 class="panel__heading">{{ $t('overview.title') }}</h2>
      </v-flex>
    </v-layout>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout wrap row>
          <v-flex xs12 lg8>
            <v-layout row wrap>

              <v-flex xs12>
                <employees-chart></employees-chart>
              </v-flex>

              <v-flex xs12>
                <employees-browser></employees-browser>
              </v-flex>

            </v-layout>
          </v-flex>

          <v-flex xs12 lg4>
            <v-layout row wrap>
              <v-flex xs12>
                <employment-time></employment-time>
              </v-flex>
            </v-layout>
          </v-flex>

        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import EmployeesBrowser from '@/components/widgets/EmployeesBrowser'
import EmployeesChart from '@/components/widgets/EmployeesChart'
import EmploymentTime from '@/components/widgets/EmploymentTime'

export default {
  name: 'Overview',
  components: { EmployeesChart, EmploymentTime, EmployeesBrowser },
  created() {
    this.$store.dispatch('EmployeesStore/index')
      .catch(error => {
        this.flash({ error: this.$root.$t('employees.flashes.fetch.error', { reason: this.renderError(error.response) }) })
      })
  }
}
</script>