<template>
	<div class="box box--border-primary">
		<h3 class="box__header">Upcoming</h3>

		<div class="box__list">
			<v-list>
        <v-list-tile v-for="upcoming in preparedEmployees" :key="upcoming.id" avatar>

          <v-list-tile-content>
            <v-list-tile-title><strong>{{ employeeFullname(upcoming) }}</strong> as <em>{{ upcoming.position }}</em> - {{ nextEvaluationDate(upcoming) }}</v-list-tile-title>
          </v-list-tile-content>

					<v-list-tile-action>
						<v-btn @click="newEvaluation(upcoming.id)" color="green" icon flat>
							<v-icon>add</v-icon>
						</v-btn>
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

import openerBus from '../../../lib/opener_bus'

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
			drafts: 'EvaluationsStore/evaluations'
		}),

		preparedEmployees() {
			let alreadyDrafted = this.drafts.models.map(evaluation => Number(evaluation.employee.id))

			let prepared = this.employees.models.filter(employee => {
				return !alreadyDrafted.includes(Number(employee.id))
			}).sort((first, second) => {
				return this.$moment().utc(first.next_evaluation_at).diff(this.$moment().utc(second.next_evaluation_at))
			})

			return prepared.slice(0, 5)
		}
	}
}
</script>