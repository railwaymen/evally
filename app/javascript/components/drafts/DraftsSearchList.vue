<template>
  <div class="sidebar">
    <div class="siedebar__search">
      <v-text-field
        v-model="search"
        append-icon="mdi-magnify"
        :label="$t('components.drafts.sidebar.search')"
        filled
      />
    </div>
    <div class="sidebar__list">
      <v-list two-line subheader>
        <v-subheader>{{ $t('components.drafts.sidebar.subheader') }}</v-subheader>

        <div v-if="loading" class="sidebar__loader">
          <v-progress-circular :size="30" :width="3" color="primary" indeterminate />
        </div>

        <template v-else>
          <v-list-item v-for="draft in searchedDrafts" :key="draft.id" :to="draft.draftPath">
            <v-list-item-content>
              <v-list-item-title>{{ draft.employeeFullname }}</v-list-item-title>
              <v-list-item-subtitle>
                {{ $t('components.drafts.sidebar.subtitle', { name: draft.template_name }) }}
              </v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>

          <v-list-item v-if="searchedDrafts.length === 0">
            <v-list-item-action>
              <v-icon>mdi-alert-circle-outline</v-icon>
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>{{ $t('components.drafts.sidebar.noContent') }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </template>
      </v-list>
    </div>
  </div>
</template>

<script>
import { EvaluationsList } from '@models/evaluation'

export default {
  name: 'DraftsSearchList',
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
