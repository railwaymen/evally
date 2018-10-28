<template>
	<div class="box box--border-primary">
		<h3 class="box__header">Drafts</h3>

		<div class="box__list">
			<v-list two-line>
        <v-list-tile v-for="draft in slicedDrafts" :key="draft.id" avatar>
          <v-list-tile-content>
            <v-list-tile-title><strong>{{ employeeFullname(draft.employee) }}</strong> as <em>{{ draft.employee.position }}</em> - {{ nextEvaluation(draft.employee) }}</v-list-tile-title>
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
		nextEvaluation(employee) {
			let date = employee.next_evaluation_at
			return date ? this.$moment(date).format('MMM YYYY') : 'First time'
		},

		edit(evaluation_id) {
			this.$store.commit('EvaluationsStore/oneDraft', evaluation_id)
			this.$router.push({ name: 'evaluations_path' })
		}
	},
	computed: {
		...mapGetters({
			drafts: 'EvaluationsStore/drafts'
		}),

		slicedDrafts() {
			return this.drafts.models.slice(0, 3)
		}
	},
	created() {
    this.$store.dispatch('EvaluationsStore/index')
      .catch( error => {
        this.flash({ error: 'Draft evaluations cannot be loaded due to some error: ' + error.message })
      })
  }
}
</script>