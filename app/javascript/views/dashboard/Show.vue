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
          <v-flex xs12 lg6>
            <drafts-list
              :drafts="drafts"
              :loading="loading"
            />
          </v-flex>

          <v-flex xs12 lg6>
            <upcoming-list
              :employees="employees"
              :templates="templates"
              :loading="loading"
            />
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapState } from 'vuex'

import DraftsList from '@components/dashboard/DraftsList'
import UpcomingList from '@components/dashboard/UpcomingList'

export default {
  name: 'DashboardShow',
  components: { DraftsList, UpcomingList },
  computed: {
    ...mapState('DashboardModule', [
      'drafts',
      'employees',
      'templates',
      'loading'
    ]),
    ...mapState('AuthenticationModule', [
      'user'
    ])
  },
  created() {
    this.$store.dispatch('DashboardModule/fetchDashboardData')
  },
  destroyed() {
    this.$store.commit('DashboardModule/RESET_STATE')
  }
}
</script>
