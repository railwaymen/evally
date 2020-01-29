<template>
  <v-layout row wrap>
    <v-flex xs3>
      <div class="employee">
        <h3 class="employee__fullname">{{ employee.fullname }}</h3>

        <h4 class="employee__position">{{ employee.position }}</h4>
        <h4 class="employee__group">{{ employee.group }}</h4>

        <h5 class="employee_hired-at">Hired at: {{ employee.hiredAt }}</h5>
        <h5 class="employee_next-review">Next review: {{ employee.nextEvaluationAt }}</h5>
      </div>

      <v-expansion-panel class="elevation-0">
        <v-expansion-panel-content>
          <template #header>
            <div>Evaluations</div>
          </template>

          <v-card>
            <v-card-text>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</v-card-text>
          </v-card>
        </v-expansion-panel-content>

        <v-expansion-panel-content>
          <template #header>
            <div>Position Changes</div>
          </template>

          <v-card>
            <v-card-text>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</v-card-text>
          </v-card>
        </v-expansion-panel-content>
      </v-expansion-panel>
    </v-flex>

    <v-flex xs9>
      <div class="box box--with-content">
        <h1>Welcome employee {{ $route.params.id }}!</h1>
      </div>
    </v-flex>
  </v-layout>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'Employee',
  computed: {
    ...mapGetters({
      employee: 'EmployeesModule/employee'
    })
  },
  watch: {
    $route: {
      immediate: true,
      handler(to, from) {
        this.$store.dispatch('EmployeesModule/show', to.params.id)
      }
    }
  },
  beforeDestroy() {
    this.$store.commit('EmployeesModule/resetItem')
  }
}
</script>
