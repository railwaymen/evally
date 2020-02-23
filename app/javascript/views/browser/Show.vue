<template>
  <div class="browser">
    <v-form
      ref="form"
      v-if="!accessible"
      @submit.prevent="enter"
      class="browser-form"
    >
      <div class="main__bg" />

      <div class="browser-form__content">
        <div class="browser-form__logo">
          <img src="@assets/images/logo_black.png" alt="Logo Evally">
        </div>

        <p class="browser-form__info">{{ $t('views.browser.show.instruction') }}</p>

        <v-text-field
          v-model="pass"
          :rules="[correctPassRule]"
        />

        <div class="browser-form__action mt-4">
          <v-btn color="primary" type="submit" outlined block rounded>Enter</v-btn>
        </div>
      </div>
    </v-form>

    <v-container v-else grid-list-lg fluid>
      <v-layout row wrap>
        <v-flex xs6>
          <img src="@assets/images/logo_black.png" alt="Logo Evally" height="48">
        </v-flex>

        <v-flex xs6>
          <div class="text-right">
            <v-tooltip bottom>
              <template #activator="{ on }">
                <v-btn
                  @click="close"
                  v-on="on"
                  color="grey"
                  icon
                >
                  <v-icon>mdi-close</v-icon>
                </v-btn>
              </template>

              <span>{{ $t('shared.tooltips.close') }}</span>
            </v-tooltip>
          </div>
        </v-flex>

        <v-flex xs10 offset-xs1 lg3 offset-lg0>
          <employee-sidebar
            :employee="employee"
            :evaluations="evaluations"
            :positionChanges="positionChanges"
          />
        </v-flex>

        <v-flex xs12 lg9>
          <div v-if="$route.name === 'employee_browse_path'" class="box">
            <v-layout row>
              <v-flex xs12>
                <h4 class="box__header">
                  {{ $t('views.employees.show.instruction') }}
                </h4>
              </v-flex>
            </v-layout>
          </div>

          <router-view v-else />
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

import EmployeeSidebar from '@components/browser/EmployeeSidebar'

export default {
  name: 'BrowseEmployee',
  components: { EmployeeSidebar },
  data() {
    return {
      valid: false,
      pass: ''
    }
  },
  methods: {
    enter() {
      this.valid = this.$refs.form.validate()
    },
    correctPassRule(val) {
      return val === this.employee.last_name || 'Text is not correct. Try again'
    },
    close() {
      this.valid = false
      this.pass = ''
    }
  },
  computed: {
    accessible() {
      return this.employee.isPersisted && this.valid
    },
    ...mapGetters({
      employee: 'EmployeesModule/employee',
      evaluations: 'EmployeesModule/evaluations',
      positionChanges: 'EmployeesModule/positionChanges'
    })
  },
  created() {
    this.$store.dispatch('EmployeesModule/browse', this.$route.params.employeeId)
  },
  beforeDestroy() {
    this.$store.commit('EmployeesModule/resetItem')
  }
}
</script>
