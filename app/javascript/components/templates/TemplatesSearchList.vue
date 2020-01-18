<template>
  <div class="search-box">
    <div class="search-box__input">
      <v-text-field
        v-model="search"
        append-icon="search"
        :label="$t('templates.sidebar.search')"
        box
      />
    </div>

    <div class="search-box__list">
      <v-list>
        <v-subheader>{{ $t('templates.sidebar.subheader') }}</v-subheader>

        <div v-if="loading" class="box__loader">
          <v-progress-circular :size="30" :width="3" color="primary" indeterminate></v-progress-circular>
        </div>

        <template v-else>
          <v-list-tile
            v-for="template in searchedTemplates"
            :key="template.id"
            avatar
          >
            <v-list-tile-avatar>
              <v-icon>list_alt</v-icon>
            </v-list-tile-avatar>

            <v-list-tile-content>
              <v-list-tile-title>{{ template.name }}</v-list-tile-title>
            </v-list-tile-content>

          </v-list-tile>

          <v-list-tile v-if="searchedTemplates.length === 0">
            <v-list-tile-action>
              <v-icon>error_outline</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title>{{ $t('templates.sidebar.no_items') }}</v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
        </template>
      </v-list>
    </div>
  </div>
</template>

<script>
import { TemplatesList } from '@models/template'

export default {
  name: 'TemplatesSearchList',
  props: {
    loading: {
      type: Boolean,
      required: true,
      default: false
    },
    templates: {
      type: TemplatesList,
      required: true,
      default: () => new TemplatesList()
    }
  },
  data() {
    return {
      search: ''
    }
  },
  computed: {
    searchedTemplates() {
      if (this.search.length === 0) return this.templates.models

      return this.templates.models.filter(template => (
        template.name.toLowerCase().indexOf(this.search.toLowerCase()) > -1
      ))
    }
  }
}
</script>
