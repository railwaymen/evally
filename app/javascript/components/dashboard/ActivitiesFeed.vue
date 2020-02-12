<template>
  <div class="widget widget--border-primary">
		<h3 class="widget__header">
      {{ $t('components.dashboard.activitiesFeed.title') }}
    </h3>

		<div class="widget__body">
			<div v-if="loading" class="widget__loader">
				<v-progress-circular :size="30" :width="3" color="primary" indeterminate />
			</div>

      <v-list v-else two-line>
        <v-list-item v-for="activity in activities.models" :key="activity.id">
          <v-list-item-content>
            <v-list-item-title>{{ activity.title }}</v-list-item-title>
						<v-list-item-subtitle>{{ activity.description }}</v-list-item-subtitle>
          </v-list-item-content>

					<v-list-item-action>
            <v-list-item-action-text>
							<v-tooltip bottom>
                <template #activator="{ on }">
								  <span v-on="on">{{ activity.shortCreatedAtFromNow }}</span>
                </template>

								<span>{{ activity.createdAt }}</span>
							</v-tooltip>
						</v-list-item-action-text>
					</v-list-item-action>
        </v-list-item>

        <v-list-item v-if="activities.isEmpty">
          <v-list-item-content>
            <v-list-item-title>
              {{ $t('components.dashboard.activitiesFeed.noContent') }}
            </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
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
