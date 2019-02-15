<template>
	<div class="box box--border-grey">
		<h3 class="box__header text-xs-center">{{ $t('dashboard.activities.title') }}</h3>

		<div class="box__body">
			<div v-if="isLoading" class="box__loader">
				<v-progress-circular :size="30" :width="3" color="primary" indeterminate></v-progress-circular>
			</div>

			<v-list v-else :two-line="activities.models.length > 0">
        <v-list-tile v-for="activity in activities.models" :key="activity.id" avatar>

          <v-list-tile-content>
            <v-list-tile-title>{{ activity.title }}</v-list-tile-title>
						<v-list-tile-sub-title>{{ activity.description }}</v-list-tile-sub-title>
          </v-list-tile-content>

					<v-list-tile-action>
            <v-list-tile-action-text>
							<v-tooltip bottom>
								<span slot="activator">{{ dateShorthand(activity.created_at) }}</span>
								<span>{{ activity.created_at | moment('HH:mm') }}</span>
							</v-tooltip>
						</v-list-tile-action-text>
					</v-list-tile-action>
        </v-list-tile>

				<v-list-tile v-if="activities.models.length == 0">
          <v-list-tile-content>
            <v-list-tile-title>{{ $t('dashboard.activities.no_activities') }}</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>

				<div class="text-xs-center pt-2">
					<v-btn :to="{ name: 'activities_archive_path' }" flat>{{ $t('dashboard.activities.see_more') }}</v-btn>
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
			activities: 'ActivitiesStore/todayActivities',
			status: 'ActivitiesStore/status'
		})
	},
	created() {
		this.$store.dispatch('ActivitiesStore/today')
      .catch( error => {
        this.flash({ error: this.$t('activities.flashes.fetch.error', { reason: this.renderError(error.response) }) })
      })
	}
}
</script>