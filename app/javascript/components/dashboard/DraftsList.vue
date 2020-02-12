<template>
  <div class="widget widget--border-primary">
		<h3 class="widget__header">
      {{ $t('components.dashboard.drafts.title') }}
    </h3>

		<div class="widget__body">
			<div v-if="loading" class="widget__loader">
				<v-progress-circular :size="30" :width="3" color="primary" indeterminate />
			</div>

      <v-list v-else two-line>
        <v-list-tile v-if="drafts.isEmpty">
          <v-list-tile-action>
            <v-icon>done_all</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>{{ $t('components.dashboard.drafts.noContent') }}</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>

        <v-list-tile v-for="draft in drafts.models" :key="draft.id" avatar>
          <v-list-tile-content>
            <v-list-tile-title>
							<strong>{{ draft.employeeFullname }}</strong>
							{{ $t('components.dashboard.drafts.as') }}
							<em>{{ draft.employee_position }}</em> - {{ draft.nextEvaluationAt }}
						</v-list-tile-title>
            <v-list-tile-sub-title>
              {{ $t('components.dashboard.drafts.updated', { date: draft.updatedAtFromNow }) }}
            </v-list-tile-sub-title>
          </v-list-tile-content>

					<v-list-tile-action>
            <v-tooltip bottom>
              <template #activator="{ on }">
                <v-btn :to="draft.draftPath" v-on="on" color="grey" flat icon>
									<v-icon>edit</v-icon>
								</v-btn>
              </template>

              <span>{{ $t('shared.tooltips.edit') }}</span>
            </v-tooltip>
					</v-list-tile-action>
        </v-list-tile>
      </v-list>
		</div>
  </div>
</template>

<script>
import { EvaluationsList } from '@models/evaluation'

export default {
  name: 'DraftsList',
  props: {
    loading: {
      type: Boolean,
      required: true,
      default: true
    },
    drafts: {
      type: EvaluationsList,
      required: true,
      default: () => new EvaluationsList()
    }
  }
}
</script>
