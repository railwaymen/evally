<template>
  <div class="box">
    <div class="box__list">
      <v-list two-line subheader>
        <v-subheader>Evaluations drafts</v-subheader>

        <v-list-tile v-for="draft in drafts.models" :key="draft.id" @click="selectEvaluation(draft.id)">
          <v-list-tile-action>
            <v-icon>person_outline</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>{{ employeeFullname(draft.employee) }}</v-list-tile-title>
            <v-list-tile-sub-title>based on '{{ draft.template_name }}' template</v-list-tile-sub-title>
          </v-list-tile-content>
        </v-list-tile>

        <v-list-tile v-if="drafts.models.length == 0">
          <v-list-tile-action>
            <v-icon>error_outline</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>There are no evaluations drafts</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'EvaluationDraftsBox',
  methods: {
    selectEvaluation(evaluation_id) {
      this.$store.commit('EvaluationsStore/oneDraft', evaluation_id)
    }
  },
  computed: {
    ...mapGetters({
      drafts: 'EvaluationsStore/drafts',
    })
  },
  created() {
    this.$store.dispatch('EvaluationsStore/index')
      .catch( error => {
        this.flash({ error: 'Draft evaluations cannot be loaded due to some error: ' + error.message })
      })
  }
}
</script>
