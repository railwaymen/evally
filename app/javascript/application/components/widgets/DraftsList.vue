<template>
	<div class="box box--border-primary">
		<h3 class="box__header">Drafts</h3>

		<div class="box__list">
			<div v-if="isLoading" class="box__loader">
				<v-progress-circular :size="30" :width="3" color="primary" indeterminate></v-progress-circular>
			</div>

			<v-list v-else two-line>
        <v-list-tile v-for="draft in sortedDrafts" :key="draft.id" avatar>
          <v-list-tile-content>
            <v-list-tile-title><strong>{{ fullname(draft.employee) }}</strong> as <em>{{ draft.employee.position }}</em> - {{ nextEvaluationDate(draft.employee) }}</v-list-tile-title>
            <v-list-tile-sub-title>Updated {{ $moment(draft.updated_at).fromNow() }}</v-list-tile-sub-title>
          </v-list-tile-content>

					<v-list-tile-action>
						<div class="">
							<v-btn @click="edit(draft.id)" color="grey" flat icon>
								<v-icon>edit</v-icon>
							</v-btn>
						</div>
					</v-list-tile-action>
        </v-list-tile>

				<v-list-tile v-if="drafts.models.length == 0">
          <v-list-tile-action>
            <v-icon>done_all</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>There are no draft evaluations to show</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
		</div>
	</div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
	name: 'DraftsList',
	methods: {
		edit(evaluation_id) {
			this.$store.commit('EvaluationsStore/one', evaluation_id)
			this.$router.push({ name: 'evaluations_path' })
		}
	},
	computed: {
		...mapGetters({
			drafts: 'EvaluationsStore/evaluations',
			status: 'EvaluationsStore/status',
			setting: 'AuthStore/setting'
		}),

		sortedDrafts() {
			let sorted = this.$_(this.drafts.models)
				.orderBy(evaluation => {
					let employee = evaluation.employee

					if (!employee.next_evaluation_at) return this.$moment().format('YYYYMMDD')
					return this.$moment(employee.next_evaluation_at).format('YYYYMMDD')
				})
				.value()

			return sorted.slice(0, this.setting.default_draft_items)
		}
	}
}
</script>