<template>
  <div class="box box--border-primary">
		<h3 class="box__header">{{ $t('widgets.employment.title') }}</h3>

    <div v-if="isLoading" class="box__loader">
      <v-progress-circular :size="30" :width="3" color="primary" indeterminate></v-progress-circular>
    </div>

    <div v-else-if="sortedEmployees.length < 2" class="employment">
      <p class="employment__no-data">{{ $t('widgets.employment.no_data_info') }}</p>
    </div>

    <div v-else class="employment">
      <div class="employment__average">
        <h3>{{ averageEmployment() }}</h3>
        <p>{{ $t('widgets.employment.average') }}</p>
      </div>

      <div class="box__body">
        <div class="text-xs-center">
          <v-btn @click="order = 'desc'" :color="activeBtnColor('desc')" flat>{{ $t('widgets.employment.buttons.shortest') }}</v-btn>
          <v-btn @click="order = 'asc'" :color="activeBtnColor('asc')" flat>{{ $t('widgets.employment.buttons.longest') }}</v-btn>
        </div>
        <v-list two-line>
          <v-list-tile v-for="(employee, index) in sortedEmployees" :key="employee.id" avatar>
            <v-list-tile-content>
              <v-list-tile-title>
                {{ index + 1 }}. <strong>{{ employee.fullname() }}</strong>
                {{ $t('widgets.employment.list_items.as') }}
                <em>{{ employee.position }}</em>
              </v-list-tile-title>
              <v-list-tile-sub-title>{{ employment(employee.hired_at) }}</v-list-tile-sub-title>
            </v-list-tile-content>

            <v-list-tile-action>
              <div class="">
                <v-tooltip bottom>
                  <v-btn @click="showProfile(employee.id)" slot="activator" color="grey" flat icon>
                    <v-icon>person</v-icon>
                  </v-btn>
                  <span>{{ $t('widgets.employment.view_profile') }}</span>
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

import employment from '@/lib/mixins/employment'

export default {
  name: 'EmploymentTime',
  mixins: [employment],
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

    averageEmployment() {
      let monthsDurations = _.map(this.employees.models, employee => {
        return this.$moment().diff(employee.hired_at, 'months')
      })

      let months = 0
      let years = 0

      if (monthsDurations.length > 0) {
        let average = Math.floor(monthsDurations.reduce((a, b) => a + b) / monthsDurations.length)

        months = average % 12
        years = Math.floor(average / 12)
      }

      // up to 1 year
      if (years === 0 && months >= 0) return [months, this.$tc('widgets.employment.list_items.month', months)].join(' ')

      // full years case
      if (years > 0 && months === 0) return [years, this.$tc('widgets.employment.list_items.year', years)].join(' ')

      return [
        years,
        this.$tc('widgets.employment.list_items.year', years),
        this.$t('widgets.employment.list_items.and'),
        months,
        this.$tc('widgets.employment.list_items.month', months)
      ].join(' ')
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
