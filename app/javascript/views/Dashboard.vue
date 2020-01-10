<template>
  <section class="panel">
    <v-layout row>
      <v-flex xs12>
        <h2 class="panel__heading">{{ $t('dashboard.title', { name: user.first_name }) }}</h2>
      </v-flex>
    </v-layout>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout wrap row>
          <v-flex xs12 lg8>
            <v-layout row wrap>

              <v-flex xs12>
                <drafts-list
                  :drafts="drafts"
                  :loading="loading"
                />
              </v-flex>

              <v-flex xs12>
                <upcoming-list
                  :employees="employees"
                  :templates="templates"
                  :loading="loading"
                />
              </v-flex>

            </v-layout>
          </v-flex>

          <v-flex xs12 lg4>
            <activity-feed
              :activities="activities"
              :loading="loading"
            />
          </v-flex>

        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapGetters } from 'vuex'

import { EmployeesList } from '@models/employee'
import { EvaluationsList } from '@models/evaluation'
import { ActivitiesList } from '@models/activity'
import { TemplatesList } from '@models/template'

import DraftsList from '@components/dashboard/DraftsList'
import UpcomingList from '@components/dashboard/UpcomingList'
import ActivityFeed from '@components/dashboard/ActivityFeed'

export default {
  name: 'Dashboard',
  components: {
    DraftsList,
    UpcomingList,
    ActivityFeed
  },
  data: () => ({
    loading: true,
    employees: new EmployeesList(),
    drafts: new EvaluationsList(),
    activities: new ActivitiesList(),
    templates: new TemplatesList()
  }),
  computed: {
    ...mapGetters({
      user: 'AuthStore/user'
    })
  },
  created() {
    this.$http.get('/v2/dashboard')
      .then(response => {
        const { employees, drafts, activities, templates } = response.data

        this.employees = new EmployeesList(employees)
        this.drafts = new EvaluationsList(drafts)
        this.activities = new ActivitiesList(activities)
        this.templates = new TemplatesList(templates)
      })
      .finally(() => {
        this.loading = false
      })
  }
}
</script>
