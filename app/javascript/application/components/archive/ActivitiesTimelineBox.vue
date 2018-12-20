<template>
  <div class="box box--with-content">
    <div v-if="isLoading" class="box__loader">
      <v-progress-circular :size="30" :width="3" color="primary" indeterminate></v-progress-circular>
    </div>

    <v-timeline v-else-if="activitiesExist" class="timeline" dense clipped>

      <template v-for="(group, key) in groupedActivities">
        <v-timeline-item hide-dot :key="key">
          <v-chip label color="primary" text-color="white">
            {{ key | moment("MMMM D, YYYY") }}
          </v-chip>
        </v-timeline-item>

        <v-timeline-item v-for="activity in group" :key="activity.id" color="grey" small>
          <div class="activity">
            <div class="activity__timing">{{ activity.created_at | moment("HH:mm") }}</div>
            <div class="activity__text">
              <h4 class="activity__title">{{ activity.title }}</h4>
              <p class="activity__description">{{ activity.description }}</p>
            </div>
          </div>
        </v-timeline-item>
      </template>
    </v-timeline>

    <v-layout v-else row>
      <v-flex xs12>
        <h4 class="no-content__header no-content__header--large">{{ $t('archive.messages.no_activities') }}</h4>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'ActivitiesTimelineBox',
  computed: {
    ...mapGetters({
      activities: 'ActivitiesStore/allActivities',
      status: 'ActivitiesStore/status'
    }),

    groupedActivities() {
      return this.$_.groupBy(this.activities.models, activity => {
        return this.$moment(activity.created_at).startOf('day').format()
      })
    },

    activitiesExist() {
      return Object.keys(this.groupedActivities).length > 0
    }
  },
  created() {
    this.$store.dispatch('ActivitiesStore/index')
      .catch(error => {
        this.flash({ error: this.$root.$t('activities.flashes.fetch.error', { reason: this.renderError(error.response) }) })
      })
  }
}
</script>

