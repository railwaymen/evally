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
        <v-list-item v-if="drafts.isEmpty">
          <v-list-item-action>
            <v-icon>done_all</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>{{ $t('components.dashboard.drafts.noContent') }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-list-item v-for="draft in drafts.models" :key="draft.id">
          <v-list-item-content>
            <v-list-item-title>
							<strong>{{ draft.employeeFullname }}</strong>
							{{ $t('components.dashboard.drafts.as') }}
							<em>{{ draft.employee_position }}</em> - {{ draft.nextEvaluationAt }}
						</v-list-item-title>
            <v-list-item-subtitle>
              {{ $t('components.dashboard.drafts.updated', { date: draft.updatedAtFromNow }) }}
            </v-list-item-subtitle>
          </v-list-item-content>

					<v-list-item-action>
            <v-tooltip bottom>
              <template #activator="{ on }">
                <v-btn :to="draft.draftPath" v-on="on" color="grey" icon>
									<v-icon>edit</v-icon>
								</v-btn>
              </template>

              <span>{{ $t('shared.tooltips.edit') }}</span>
            </v-tooltip>
					</v-list-item-action>
        </v-list-item>
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
