<template>
  <div class="panel">
    <v-layout>
      <v-flex xs12 md6 lg3>
        <h2 class="size-27 font-weight-light mb-5">
          {{ $t('views.recruitments.overview.monthlyReport') }}
        </h2>

        <v-select
          v-model="currentDate"
          :items="months"
          :label="$t('views.recruitments.overview.monthSelectLabel')"
          item-text="text"
          item-value="value"
          filled
        />
      </v-flex>
    </v-layout>

    <v-layout row wrap>
      <v-flex xs12 lg6>
        <groups-chart-widget
          interval="day"
          :chartData="groupsMonthlyChartData"
          :groups="groups"
        />
      </v-flex>

      <v-flex xs12 lg6>
        <sources-chart-widget
          interval="day"
          :chartData="sourcesMonthlyChartData"
          :sources="sources"
          color="secondary"
        />
      </v-flex>
    </v-layout>

    <v-layout>
      <v-flex xs12 md6 lg3>
        <h2 class="size-27 font-weight-light mb-5">{{ $t('views.recruitments.overview.yearlyReport', { year: currentYear }) }}</h2>
      </v-flex>
    </v-layout>

    <v-layout row wrap>
      <v-flex xs12 lg6>
        <groups-chart-widget
          interval="month"
          :chartData="groupsYearlyChartData"
          :groups="groups"
        />
      </v-flex>

      <v-flex xs12 lg6>
        <sources-chart-widget
          interval="month"
          :chartData="sourcesYearlyChartData"
          :sources="sources"
          color="secondary"
        />
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapActions, mapState } from 'vuex'

import GroupsChartWidget from '@components/recruitments/GroupsChartWidget'
import SourcesChartWidget from '@components/recruitments/SourcesChartWidget'

export default {
  name: 'RecruitmentsOverview',
  components: { GroupsChartWidget, SourcesChartWidget },
  data() {
    const validMoment = this.$moment(this.$route.query.date)

    return {
      currentDate: (validMoment || this.moment()).format('YYYY-MM-01'),
    }
  },
  methods: {
    ...mapActions('RecruitmentsOverviewModule', [
      'fetchData'
    ])
  },
  computed: {
    ...mapState('RecruitmentsOverviewModule', [
      'groups',
      'groupsMonthlyChartData',
      'groupsYearlyChartData',
      'sources',
      'sourcesMonthlyChartData',
      'sourcesYearlyChartData',
      'months',
      'loading'
    ]),
    currentYear() {
      return this.$moment(this.currentDate).format('YYYY')
    }
  },
  watch: {
    currentDate(newCurrentDate) {
      this.$router.push({ name: 'recruitments_overview_path', query: { date: newCurrentDate } })
      this.fetchData(newCurrentDate)
    }
  },
  created() {
    this.fetchData(this.currentDate)
  }
}
</script>
