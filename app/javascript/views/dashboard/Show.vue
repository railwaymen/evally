<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">
        <h2>{{ $t('views.dashboards.show.title', { name: user.first_name }) }}</h2>
      </div>
    </div>

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
            <activities-feed
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

import { coreApiClient } from '@utils/api_clients'

import { Employee, EmployeesList } from '@models/employee'
import { EvaluationsList } from '@models/evaluation'
import { ActivitiesList } from '@models/activity'
import { TemplatesList } from '@models/template'

import DraftsList from '@components/dashboard/DraftsList'
import UpcomingList from '@components/dashboard/UpcomingList'
import ActivitiesFeed from '@components/dashboard/ActivitiesFeed'

export default {
  name: 'DashboardShow',
  components: {
    DraftsList,
    UpcomingList,
    ActivitiesFeed
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
      user: 'AuthenticationModule/user'
    })
  },
  created() {
    coreApiClient
      .get('/v2/dashboard')
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
