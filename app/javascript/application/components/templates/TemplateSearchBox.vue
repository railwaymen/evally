<template>
  <div class="search-box">
    <div class="search-box__input">
      <v-text-field
        v-model="search"
        append-icon="search"
        :label="$t('templates.sidebar.search')"
        box
      ></v-text-field>
    </div>

    <div class="search-box__list">
      <v-list>
        <v-subheader>{{ $t('templates.sidebar.subheader') }}</v-subheader>

        <div v-if="isLoading" class="box__loader">
          <v-progress-circular :size="30" :width="3" color="primary" indeterminate></v-progress-circular>
        </div>

        <template v-else>
          <v-list-tile v-for="template in filteredTemplates" :key="template.id" @click="selectTemplate(template.id)" avatar>
            <v-list-tile-avatar>
              <v-icon>list_alt</v-icon>
            </v-list-tile-avatar>

            <v-list-tile-content>
              <v-list-tile-title>{{ template.name }}</v-list-tile-title>
            </v-list-tile-content>

          </v-list-tile>

          <v-list-tile v-if="filteredTemplates.length == 0">
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
import { mapGetters } from 'vuex'

export default {
  name: 'TemplateSearchBox',
  data () {
    return {
      search: ''
    }
  },
  methods: {
    selectTemplate(template_id) {
      // this.template.reset()

      this.$store.commit('TemplatesStore/one', template_id)
      this.$store.commit('SectionsStore/many', this.template.sections_attributes)
    }
  },
  computed: {
    ...mapGetters({
      templates: 'TemplatesStore/templates',
      template: 'TemplatesStore/template',
      status: 'TemplatesStore/status'
    }),
    filteredTemplates() {
      let outputArray = []

      if (this.search.length > 0) {
        outputArray = this.templates.models.filter(template => {
          return template.name.toLowerCase().indexOf(this.search.toLowerCase()) > -1
        })
      } else {
        outputArray = this.templates.models
      }

      return outputArray.sort((a, b) => a.name.localeCompare(b.name))
    }
  }
}
</script>
