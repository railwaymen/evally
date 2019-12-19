<template>
  <div class="box box--border-primary">
		<h3 class="box__header">{{ $t('dashboard.drafts.title') }}</h3>

		<div class="box__body">
			<div v-if="loading" class="box__loader">
				<v-progress-circular :size="30" :width="3" color="primary" indeterminate></v-progress-circular>
			</div>

      <v-list v-else two-line>
        <v-list-tile v-if="evaluations.isEmpty">
          <v-list-tile-action>
            <v-icon>done_all</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>There are no draft evaluations to show</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>

        <v-list-tile v-for="evaluation in evaluations.models" :key="evaluation.id" avatar>
          <v-list-tile-content>
            <v-list-tile-title>
							<strong>{{ evaluation.employeeFullname }}</strong>
							{{ $t('dashboard.common.as') }}
							<em>{{ evaluation.employee_position }}</em> - {{ evaluation.nextEvaluationAt }}
						</v-list-tile-title>
            <v-list-tile-sub-title>{{ $t('dashboard.drafts.updated', { date: evaluation.updatedAtFromNow }) }}</v-list-tile-sub-title>
          </v-list-tile-content>

					<v-list-tile-action>
						<div class="">
							<v-tooltip bottom>
								<v-btn slot="activator" color="grey" flat icon>
									<v-icon>edit</v-icon>
								</v-btn>
								<span>{{ $t('dashboard.drafts.edit_tooltip') }}</span>
							</v-tooltip>
						</div>
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
    evaluations: {
      type: EvaluationsList,
      required: true,
      default: () => new EvaluationsList()
    }
  }
}
</script>
