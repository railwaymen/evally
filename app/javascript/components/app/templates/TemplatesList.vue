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
        <v-subheader>Evaluation templates</v-subheader>

        <v-list-tile v-for="template in filteredTemplates" :key="template.id" @click="" avatar>
          <v-list-tile-avatar>
						<v-icon>description</v-icon>
					</v-list-tile-avatar>

          <v-list-tile-content>
            <v-list-tile-title>{{ template.name }}</v-list-tile-title>
            <v-list-tile-sub-title>{{ template.completed_count }} evaluations completed</v-list-tile-sub-title>
          </v-list-tile-content>

          <v-list-tile-action>
						<div class="">
							<v-btn color="grey" flat icon>
								<v-icon>not_interested</v-icon>
							</v-btn>
						</div>
					</v-list-tile-action>
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
      search: '',
      templates: {
        models: [
          { id: 0, name: 'Rubies', completed_count: 7 },
          { id: 1, name: 'JS Wizzards', completed_count: 6 },
          { id: 2, name: 'CSS Masters', completed_count: 4 },
          { id: 3, name: 'Scala Kings', completed_count: 5 },
          { id: 4, name: 'Python Heroes', completed_count: 3 },
          { id: 5, name: 'PR Magicians', completed_count: 2 }
        ]
      }
    }
  },
  computed: {
    ...mapGetters({
      evaluationTemplates: 'EvaluationTemplatesStore/evaluationTemplates'
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
  }
}
</script>