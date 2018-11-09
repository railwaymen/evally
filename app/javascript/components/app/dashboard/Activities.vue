<template>
	<div class="box box--border-grey">
		<h3 class="box__header text-xs-center">Activities</h3>

		<div class="box__list">
			<v-list two-line>
        <v-list-tile v-for="activity in activities.models" :key="activity.id" avatar>

          <v-list-tile-content>
            <v-list-tile-title>{{ activity.title }}</v-list-tile-title>
						<v-list-tile-sub-title>{{ activity.description }}</v-list-tile-sub-title>
          </v-list-tile-content>

					<v-list-tile-action>
            <v-list-tile-action-text>{{ dateShorthand(activity.created_at) }}</v-list-tile-action-text>
					</v-list-tile-action>
        </v-list-tile>
      </v-list>

			<a href="#" style="font-size: 1.6rem; color: black; text-align: center; display: block;">See more</a>
		</div>
	</div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
	name: 'Activities',
	data () {
		return {
			date: this.$moment().utc(),
		}
	},
	methods: {
		dateShorthand(date) {
			let interval

			let diff = this.$moment().diff(this.$moment(date), 'seconds')

			interval = Math.floor(diff / 31536000)
			if (interval >= 1) return `${interval}Y`

			interval = Math.floor(diff / 2592000)
			if (interval >= 1) return `${interval}M`

			interval = Math.floor(diff / 604800)
			if (interval >= 1) return `${interval}w`

			interval = Math.floor(diff / 86400)
			if (interval >= 1) return `${interval}d`

			interval = Math.floor(diff / 3600)
			if (interval >= 1) return `${interval}h`

			interval = Math.floor(diff / 60)
			if (interval >= 1) return `${interval}m`

			return `${diff}s`
		}
	},
	computed: {
		...mapGetters({
			activities: 'ActivitiesStore/activities'
		})
	},
	created() {
		this.$store.dispatch('ActivitiesStore/index', this.date)
      .catch( error => {
        this.flash({ error: 'Activities cannot be loaded due to some error: ' + this.renderError(error.response) })
      })
	}
}
</script>