<template>
  <div class="search-box">
    <div class="search-box__input">
      <v-text-field
        v-model="search"
        append-icon="search"
        :label="$t('evaluations.sidebar.search')"
        box
      ></v-text-field>
    </div>
    <div class="search-box__list">
      <v-list two-line subheader>
        <v-subheader>{{ $t('evaluations.sidebar.subheader') }}</v-subheader>

        <div v-if="isLoading" class="box__loader">
          <v-progress-circular :size="30" :width="3" color="primary" indeterminate></v-progress-circular>
        </div>

        <template v-else>
          <v-list-tile v-for="draft in filteredEvaluations" :key="draft.id" @click="pickEvaluation(draft.id)">
            <v-list-tile-action>
              <v-icon>assignment_turned_in</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title>{{ draft.employeeName() }}</v-list-tile-title>
              <v-list-tile-sub-title>{{ $t('evaluations.sidebar.subtitle', { name: draft.template_name }) }}</v-list-tile-sub-title>
            </v-list-tile-content>
          </v-list-tile>

          <v-list-tile v-if="filteredEvaluations.length == 0">
            <v-list-tile-action>
              <v-icon>error_outline</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title>{{ $t('evaluations.sidebar.no_items') }}</v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
        </template>
      </v-list>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'EvaluationDraftsBox',
  data() {
    return {
      search: ''
    }
  },
  methods: {
    pickEvaluation(id) {
      this.$store.commit('EvaluationsStore/pick', id)
      this.$store.commit('SectionsStore/many', this.evaluation.sections_attributes)
    }
  },
  computed: {
    ...mapGetters({
      drafts: 'EvaluationsStore/evaluationsDrafts',
      evaluation: 'EvaluationsStore/evaluation',
      status: 'EvaluationsStore/status'
    }),

    filteredEvaluations() {
      if (this.search.length > 0) {
        return this.drafts.models.filter(draft => {
          return draft.employeeName().toLowerCase().indexOf(this.search.toLowerCase()) > -1
        })
      } else {
        return this.drafts.models
      }
    }
  }
}
</script>
