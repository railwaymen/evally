<template>
  <div class="search-box">
    <div class="search-box__input">
      <v-text-field
        v-model="search"
        append-icon="search"
        label="Search ..."
        box
      ></v-text-field>
    </div>

    <div class="search-box__list">
      <v-list two-line>
        <v-subheader>All templates</v-subheader>

        <v-list-tile v-for="template in filteredTemplates" :key="template.id" @click="selectTemplate(template.id)" avatar>
          <v-list-tile-avatar>
						<v-icon>description</v-icon>
					</v-list-tile-avatar>

          <v-list-tile-content>
            <v-list-tile-title>{{ template.name }}</v-list-tile-title>
            <v-list-tile-sub-title>{{ template.evaluations_count }} evaluations completed</v-list-tile-sub-title>
          </v-list-tile-content>

        </v-list-tile>

        <v-list-tile v-if="filteredTemplates.length == 0">
          <v-list-tile-action>
            <v-icon>error_outline</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>There are no templates to show</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>

      </v-list>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'TemplatesList',
  data () {
    return {
      search: ''
    }
  },
  methods: {
    selectTemplate(template_id) {
      this.template.reset()
      this.$store.commit('TemplatesStore/one', template_id)
    }
  },
  computed: {
    ...mapGetters({
      templates: 'TemplatesStore/templates',
      template: 'TemplatesStore/template'
    }),
    filteredTemplates() {
      if (this.search.length > 0) {
        return this.templates.models.filter(template => {
          return template.name.toLowerCase().indexOf(this.search.toLowerCase()) > -1
        })
      } else {
        return this.templates.models
      }
    }
  },
  mounted() {
    this.$store.dispatch('TemplatesStore/index')
      .catch( error => {
        this.flash({ error: 'Templates cannot be loaded due to some error: ' + error.message })
      })
  }
}
</script>