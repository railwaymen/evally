<template>
  <section class="panel">
    <v-layout row>
      <v-flex xs6>
        <h2 class="panel__heading">Templates</h2>
      </v-flex>

      <v-flex>
        <div class="panel__action-bar">
          <v-btn color="green" @click="newTemplate" flat>
            <v-icon>add</v-icon> New template
          </v-btn>

          <template v-if="template.isExisting() || status === 'new_record'">
            <v-btn v-if="template.editable" @click="save" flat>
              <v-icon>save_alt</v-icon> Save
            </v-btn>
            <v-btn v-else @click="edit" flat>
              <v-icon>edit</v-icon> Edit
            </v-btn>

            <v-btn color="red" @click="remove" flat>
              <v-icon>delete</v-icon> Delete
            </v-btn>
          </template>

        </div>
      </v-flex>
    </v-layout>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout row>
          <v-flex xs3>
            <template-search-box></template-search-box>
          </v-flex>

          <v-flex xs9>
            <template-box></template-box>
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapGetters } from 'vuex'

import openerBus from '../../lib/opener_bus'

import TemplateBox from './templates/TemplateBox'
import TemplateSearchBox from './templates/TemplateSearchBox'

export default {
  name: 'TemplatesPage',
  components: { TemplateBox, TemplateSearchBox },
  methods: {
    newTemplate() {
      this.$store.commit('SectionsStore/clear')
      this.$store.commit('TemplatesStore/newTemplate')
    },

    edit() {
      this.$store.commit('TemplatesStore/edit')
    },

    save() {
      let formValid = this.template.validate() && _.every(this.sections.models, section => section.validate() )

      if (formValid && this.status === 'new_record') {
        this.template.sections_attributes = _.map(this.sections.models, section => section.attributes )

        this.$store.dispatch('TemplatesStore/create', this.template)
          .then(() => {
            this.flash({ success: `Template '${this.template.name}' has been succefully created` })
            this.template.editable = false
          })
          .catch(() => {
            this.flash({ error: 'Template cannot be created due to some error' })
          })
      } else if (formValid && this.status === 'record') {
        this.template.sections_attributes = _.map(this.sections.models, section => section.attributes )

        this.$store.dispatch('TemplatesStore/update', this.template)
          .then(() => {
            this.flash({ success: `Template '${this.template.name}' has been succefully updated` })
            this.template.editable = false
          })
          .catch(() => {
            this.flash({ error: 'Template cannot be updated due to some error' })
          })
      }
    },

    remove() {
      openerBus.openDestroyModal({ model: 'template', action: 'delete', maxWidth: 500 })
    }
  },
  computed: {
    ...mapGetters({
      template: 'TemplatesStore/template',
      sections: 'SectionsStore/sections',
      status: 'TemplatesStore/status'
    })
  }
}
</script>
