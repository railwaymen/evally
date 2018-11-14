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
          </v-flex>

          <v-flex xs9>
            <h1 class="headline" v-if="currentView === 0">Employees</h1>
            <activities-timeline-box v-if="isActivitiesView"></activities-timeline-box>
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import ActivitiesFilterBox from './archive/ActivitiesFilterBox'
import ActivitiesTimelineBox from './archive/ActivitiesTimelineBox'

export default {
  name: 'ArchivePage',
  components: { ActivitiesFilterBox, ActivitiesTimelineBox },
  data() {
    return {
      currentView: 1,
      views: ['employees', 'activities']
    }
  },
  computed: {
    isActivitiesView() {
      return this.currentView === this.views.indexOf('activities')
    }
  }
}
</script>