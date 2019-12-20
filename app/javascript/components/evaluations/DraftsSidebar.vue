<template>
  <div class="search-box">
    <div class="search-box__input">
      <v-text-field
        v-model="search"
        append-icon="search"
        :label="$t('evaluations.sidebar.search')"
        box
      />
    </div>
    <div class="search-box__list">
      <v-list two-line subheader>
        <v-subheader>{{ $t('evaluations.sidebar.subheader') }}</v-subheader>

        <div v-if="loading" class="box__loader">
          <v-progress-circular :size="30" :width="3" color="primary" indeterminate />
        </div>

        <template v-else>
          <v-list-tile v-for="draft in searchedDrafts" :key="draft.id">
            <v-list-tile-action>
              <v-icon>assignment_turned_in</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title>{{ draft.employeeFullname }}</v-list-tile-title>
              <v-list-tile-sub-title>{{ $t('evaluations.sidebar.subtitle', { name: draft.template_name }) }}</v-list-tile-sub-title>
            </v-list-tile-content>
          </v-list-tile>

          <v-list-tile v-if="searchedDrafts.length === 0">
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
import { EvaluationsList } from '@models/evaluation'

export default {
  name: 'DraftsSidebar',
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
  },
  data() {
    return {
      search: ''
    }
  },
  computed: {
    searchedDrafts() {
      if (this.search.length === 0) return this.drafts.models

      return this.drafts.models.filter(draft => (
        draft.employeeFullname.toLowerCase().indexOf(this.search.toLowerCase()) > -1
      ))
    }
  }
}
</script>
