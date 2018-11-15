<template>
  <div class="box pa-4">
    <v-timeline class="timeline" dense clipped>

      <template v-for="(group, key) in groupedActivities">
        <v-timeline-item hide-dot :key="key">
          <div class="timeline__date">
            <span class="subheading">{{ key | moment("MMMM Do, YYYY") }}</span>
          </div>
        </v-timeline-item>

        <v-timeline-item v-for="activity in group" :key="activity.id" small>
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
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'ActivitiesTimelineBox',
  computed: {
    ...mapGetters({
      activities: 'ActivitiesStore/allActivities'
    }),

    groupedActivities() {
      return this.$_.groupBy(this.activities.models, activity => {
        return this.$moment(activity.created_at).startOf('day').format()
      })
    }
  },
  created() {
    let params = {
      from: this.$moment().subtract(7, 'd').format('YYYY-MM-DD'),
      to: this.$moment().format('YYYY-MM-DD')
    }

    this.$store.dispatch('ActivitiesStore/index', params)
      .catch( error => {
        this.flash({ error: 'Activities cannot be loaded due to some error: ' + this.renderError(error.response) })
      })
  }
}
</script>

