<template>
  <div class="sidebar">
    <div class="siedebar__search">
      <v-text-field
        v-model="search"
        append-icon="mdi-magnify"
        :label="$t('components.evaluations.sidebar.search')"
        filled
      />
    </div>
    <div class="sidebar__list">
      <v-list two-line subheader>
        <v-subheader>{{ $t('components.evaluations.sidebar.subheader') }}</v-subheader>

        <div v-if="loading" class="sidebar__loader">
          <v-progress-circular :size="30" :width="3" color="primary" indeterminate />
        </div>

        <template v-else>
          <v-list-item
            v-for="evaluation in searchedEvaluations"
            :key="evaluation.id"
            :to="evaluation.draftPath"
            color="secondary"
          >
            <v-list-item-content>
              <v-list-item-title>{{ evaluation.fullname }}</v-list-item-title>
              <v-list-item-subtitle>
                {{ $t('components.evaluations.sidebar.subtitle', { name: evaluation.template_name }) }}
              </v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>

          <v-list-item v-if="searchedEvaluations.length === 0">
            <v-list-item-action>
              <v-icon>mdi-alert-circle-outline</v-icon>
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>
                {{ $t('components.evaluations.sidebar.noContent') }}
              </v-list-item-title>
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
  name: 'SearchList',
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
  },
  data() {
    return {
      search: ''
    }
  },
  computed: {
    searchedEvaluations() {
      if (this.search.length === 0) return this.evaluations.models

      return this.evaluations.models.filter(evaluation => (
        evaluation.fullname.toLowerCase().indexOf(this.search.toLowerCase()) > -1
      ))
    }
  }
}
</script>
