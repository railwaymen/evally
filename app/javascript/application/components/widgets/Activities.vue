<template>
	<div class="box box--border-grey">
		<h3 class="box__header text-xs-center">Activities</h3>

		<div class="box__list">
			<v-list :two-line="activities.models.length > 0">
        <v-list-tile v-for="activity in activities.models" :key="activity.id" avatar>

          <v-list-tile-content>
            <v-list-tile-title>{{ activity.title }}</v-list-tile-title>
						<v-list-tile-sub-title>{{ activity.description }}</v-list-tile-sub-title>
          </v-list-tile-content>

					<v-list-tile-action>
            <v-list-tile-action-text>{{ dateShorthand(activity.created_at) }}</v-list-tile-action-text>
					</v-list-tile-action>
        </v-list-tile>

				<v-list-tile v-if="activities.models.length == 0">
          <v-list-tile-content>
            <v-list-tile-title>No activities from today</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>

				<div class="text-xs-center pt-2">
					<v-btn :to="{ name: 'archive_path', params: { tab: 'activities' } }" flat>See more</v-btn>
				</div>
      </v-list>
		</div>
	</div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
	name: 'Activities',
	methods: {
		dateShorthand(date) {
			let interval

			let diff = this.$moment().diff(this.$moment(date), 'seconds')

			interval = Math.floor(diff / 3600)
			if (interval >= 1) return `${interval}h`

			interval = Math.floor(diff / 60)
			if (interval >= 1) return `${interval}m`

			return `${diff}s`
		}
	},
	computed: {
		...mapGetters({
			activities: 'ActivitiesStore/todayActivities'
		})
	},
	created() {
		this.$store.dispatch('ActivitiesStore/today')
      .catch( error => {
        this.flash({ error: 'Activities cannot be loaded due to some error: ' + this.renderError(error.response) })
      })
	}
}
</script>