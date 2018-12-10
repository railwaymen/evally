<template>
	<div class="box box--border-primary">
		<h3 class="box__header">{{ $t('dashboard.upcoming.title') }}</h3>

		<div class="box__list">
			<div v-if="isLoading" class="box__loader">
				<v-progress-circular :size="30" :width="3" color="primary" indeterminate></v-progress-circular>
			</div>

			<v-list v-else>
        <v-list-tile v-for="upcoming in preparedEmployees" :key="upcoming.id" avatar>

          <v-list-tile-content>
            <v-list-tile-title>
							<strong>{{ upcoming.fullname() }}</strong>
							{{ $t('dashboard.common.as') }}
							<em>{{ upcoming.position }}</em> - {{ nextEvaluationDate(upcoming) }}
						</v-list-tile-title>
          </v-list-tile-content>

					<v-list-tile-action>
						<v-tooltip bottom>
							<v-btn @click="newEvaluation(upcoming.id)" slot="activator" color="green" icon flat>
								<v-icon>add</v-icon>
							</v-btn>
							<span>{{ $t('dashboard.upcoming.new_tooltip') }}</span>
						</v-tooltip>
					</v-list-tile-action>
        </v-list-tile>

				<v-list-tile v-if="preparedEmployees.length == 0">
          <v-list-tile-action>
            <v-icon>done_all</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>There are no upcoming evaluations to show</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
		</div>
	</div>
</template>

<script>
import { mapGetters } from 'vuex'

import openerBus from '@/lib/opener_bus'

export default {
	name: 'UpcomingList',
	methods: {
		newEvaluation(employee_id) {
			openerBus.openFormModal({ 
				model: 'draft',
				action: 'create',
				maxWidth: 500,
				employee_id: employee_id,
				redirect: true
			})
			this.$store.commit('EvaluationsStore/clear')
		}
	},
	computed: {
		...mapGetters({
			employees: 'EmployeesStore/employees',
			drafts: 'EvaluationsStore/evaluations',
			status: 'EvaluationsStore/status',
			setting: 'AuthStore/setting'
		}),

		preparedEmployees() {
			let alreadyDrafted = this.$_.map(this.drafts.models, evaluation => Number(evaluation.employee.id))

			let prepared = this.$_(this.employees.models)
				.reject(employee => {
					return alreadyDrafted.includes(Number(employee.id))
				})
				.orderBy(employee => {
					if (!employee.next_evaluation_at) return this.$moment().format('YYYYMMDD')
					return this.$moment(employee.next_evaluation_at).format('YYYYMMDD')
				})
				.value()

			return prepared.slice(0, this.setting.default_upcoming_items)
		}
	}
}
</script>