<template>
  <div class="widget widget--border-primary">
		<h3 class="widget__header">
      {{ $t('components.dashboard.activitiesFeed.title') }}
    </h3>

		<div class="widget__body">
			<div v-if="loading" class="widget__loader">
				<v-progress-circular :size="30" :width="3" color="primary" indeterminate></v-progress-circular>
			</div>

      <v-list v-else two-line>
        <v-list-tile v-for="activity in activities.models" :key="activity.id" avatar>
          <v-list-tile-content>
            <v-list-tile-title>{{ activity.title }}</v-list-tile-title>
						<v-list-tile-sub-title>{{ activity.description }}</v-list-tile-sub-title>
          </v-list-tile-content>

					<v-list-tile-action>
            <v-list-tile-action-text>
							<v-tooltip bottom>
								<span slot="activator">{{ activity.shortCreatedAtFromNow }}</span>
								<span>{{ activity.createdAt }}</span>
							</v-tooltip>
						</v-list-tile-action-text>
					</v-list-tile-action>
        </v-list-tile>

        <v-list-tile v-if="activities.isEmpty">
          <v-list-tile-content>
            <v-list-tile-title>
              {{ $t('components.dashboard.activitiesFeed.noContent') }}
            </v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
		</div>
  </div>
</template>

<script>
import { ActivitiesList } from '@models/activity'

export default {
  name: 'ActivitiesFeed',
  props: {
    loading: {
      type: Boolean,
      required: true,
      default: true
    },
    activities: {
      type: ActivitiesList,
      required: true,
      default: () => new ActivitiesList()
    }
  }
}
</script>
