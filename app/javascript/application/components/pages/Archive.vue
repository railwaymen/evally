<template>
  <section class="panel">
    <v-layout row>
      <v-flex xs6>
        <h2 class="panel__heading">Archive</h2>
      </v-flex>

      <v-flex>
        <div class="panel__action-bar">
        </div>
      </v-flex>
    </v-layout>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout row>
          <v-flex xs3>
            <v-tabs v-model="currentView" grow>
              <v-tabs-slider color="primary"></v-tabs-slider>
              <v-tab v-for="(view, index) in views" :key="index">
                {{ view }}
              </v-tab>
            </v-tabs>

            <activities-filter-box v-if="isActivitiesView"></activities-filter-box>
            <employees-list-box v-if="isEmployeesView"></employees-list-box>
          </v-flex>

          <v-flex xs9>
            <employee-evaluation-box v-if="isEmployeesView"></employee-evaluation-box>
            <activities-timeline-box v-if="isActivitiesView"></activities-timeline-box>
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import ActivitiesFilterBox from '@/components/archive/ActivitiesFilterBox'
import ActivitiesTimelineBox from '@/components/archive/ActivitiesTimelineBox'

import EmployeesListBox from '@/components/archive/EmployeesListBox'
import EmployeeEvaluationBox from '@/components/employees/EmployeeEvaluationBox'

export default {
  name: 'Archive',
  components: { ActivitiesFilterBox, ActivitiesTimelineBox, EmployeesListBox, EmployeeEvaluationBox },
  data() {
    return {
      currentView: 0,
      views: ['employees', 'activities']
    }
  },
  computed: {
    isActivitiesView() {
      return this.currentView === this.views.indexOf('activities')
    },

    isEmployeesView() {
      return this.currentView === this.views.indexOf('employees')
    }
  },
  created() {
    this.currentView = this.$route.params.tab === 'activities' ? 1 : 0
  }
}
</script>