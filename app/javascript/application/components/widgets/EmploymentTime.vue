<template>
  <div class="box box--border-primary">
		<h3 class="box__header">Employment time</h3>

    <div v-if="isLoading" class="box__loader">
      <v-progress-circular :size="30" :width="3" color="primary" indeterminate></v-progress-circular>
    </div>

    <div v-else-if="sortedEmployees.length < 2" class="employment">
      <p class="employment__no-data">You have not enough employees to present this data.</p>
    </div>

    <div v-else class="employment">
      <div class="employment__average">
        <h3>{{ averageEmployment() }}</h3>
        <p>avarage</p>
      </div>

      <div class="box__body">
        <div class="text-xs-center">
          <v-btn @click="order = 'desc'" :color="activeBtnColor('desc')" flat>Shortest</v-btn>
          <v-btn @click="order = 'asc'" :color="activeBtnColor('asc')" flat>Longest</v-btn>
        </div>
        <v-list two-line>
          <v-list-tile v-for="(employee, index) in sortedEmployees" :key="employee.id" avatar>
            <v-list-tile-content>
              <v-list-tile-title>
                {{ index + 1 }}. <strong>{{ employee.fullname() }}</strong>
                {{ $t('dashboard.common.as') }}
                <em>{{ employee.position }}</em>
              </v-list-tile-title>
              <v-list-tile-sub-title>works {{ employment(employee.hired_at) }}</v-list-tile-sub-title>
            </v-list-tile-content>

            <v-list-tile-action>
              <div class="">
                <v-tooltip bottom>
                  <v-btn @click="showProfile(employee.id)" slot="activator" color="grey" flat icon>
                    <v-icon>person</v-icon>
                  </v-btn>
                  <span>View profile</span>
                </v-tooltip>
              </div>
            </v-list-tile-action>
          </v-list-tile>
        </v-list>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'EmploymentTime',
  data() {
    return {
      order: 'desc'
    }
  },
  methods: {
    showProfile(id) {
      this.$store.commit('EmployeesStore/pick', id)

      this.$router.push({ name: 'employees_path' })
    },

    employment(hired_at) {
      let diff = this.$moment().diff(hired_at, 'days')

      let days = diff % 365
      let years = Math.floor(diff / 365)

      let result = [days, this.daysSuffix(days)]
      if (years > 0) result.unshift(years, this.yearsSuffix(years), 'and')

      return result.join(' ')
    },

    averageEmployment() {
      let daysDurations = _.map(this.employees.models, employee => {
        return this.$moment().diff(employee.hired_at, 'days')
      })

      let days = 0
      let years = 0

      if (daysDurations.length > 0) {
        let average = Math.floor(daysDurations.reduce((a, b) => a + b) / daysDurations.length)

        days = average % 365
        years = Math.floor(average / 365)
      }

      let result = [days, this.daysSuffix(days)]
      if (years > 0) result.unshift(years, this.yearsSuffix(years))

      return result.join(' ')
    },

    daysSuffix(n) {
      return n === 1 ? 'day' : 'days'
    },

    yearsSuffix(n) {
      return n === 1 ? 'year' : 'years'
    },

    activeBtnColor(order) {
      return this.order === order ? 'primary' : ''
    }
  },
  computed: {
    ...mapGetters({
      employees: 'EmployeesStore/employees',
      status: 'EmployeesStore/status'
    }),

    sortedEmployees() {
      return _.orderBy(this.employees.models, employee => {
        return this.$moment(employee.hired_at)
      }, [this.order]).slice(0, 5)
    }
  }
}
</script>
