<template>
  <section class="panel">
    <v-layout row>
      <v-flex xs6>
        <h2 class="panel__heading">Templates</h2>
      </v-flex>

      <v-flex>
        <div class="panel__action-bar">
          <v-btn color="green" @click="newTemplate" flat>
            <v-icon>add</v-icon> New
          </v-btn>

          <v-menu
            :disabled="!template.isExisting() && status !== 'new_record'"
            transition="slide-y-transition"
            offset-y bottom left
          >
            <v-btn
              :disabled="!template.isExisting() && status !== 'new_record'"
              color="primary"
              slot="activator"
              icon
              flat
            >
              <v-icon>more_vert</v-icon>
            </v-btn>

            <v-list>
              <v-list-tile :disabled="!template.editable" @click="save">
                <v-list-tile-action>
                  <v-icon>save_alt</v-icon>
                </v-list-tile-action>
                <v-list-tile-title>Save</v-list-tile-title>
              </v-list-tile>

              <v-list-tile :disabled="template.editable" @click="edit">
                <v-list-tile-action>
                  <v-icon>edit</v-icon>
                </v-list-tile-action>
                <v-list-tile-title>Edit</v-list-tile-title>
              </v-list-tile>

              <v-list-tile @click="remove">
                <v-list-tile-action>
                  <v-icon>delete</v-icon>
                </v-list-tile-action>
                <v-list-tile-title>Delete</v-list-tile-title>
              </v-list-tile>
            </v-list>
          </v-menu>
        </div>
      </v-flex>
    </v-layout>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout wrap row>
          <v-flex xs10 offset-xs1 lg3 offset-lg0>
            <template-search-box></template-search-box>
          </v-flex>

          <v-flex xs12 lg9>
            <template-box></template-box>
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapGetters } from 'vuex'

import openerBus from '@/lib/opener_bus'

import TemplateBox from '@/components/templates/TemplateBox'
import TemplateSearchBox from '@/components/templates/TemplateSearchBox'

export default {
  name: 'Templates',
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

        this.$store.dispatch('TemplatesStore/create', { template: this.template })
          .then(() => {
            this.flash({ success: `Template '${this.template.name}' has been succefully created` })
            this.template.editable = false
          })
          .catch(error => {
            this.flash({ error: 'Template cannot be created due to some error: ' + this.renderError(error.response) })
          })
      } else if (formValid && this.status === 'record') {
        this.template.sections_attributes = _.map(this.sections.models, section => section.attributes )

        this.$store.dispatch('TemplatesStore/update', { template: this.template })
          .then(() => {
            this.flash({ success: `Template '${this.template.name}' has been succefully updated` })
            this.template.editable = false
          })
          .catch(error => {
            this.flash({ error: 'Template cannot be updated due to some error: ' + this.renderError(error.response) })
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
  },
  created() {
    this.$store.dispatch('TemplatesStore/index')
      .catch(error => {
        this.flash({ error: 'Templates cannot be loaded due to some error: ' + this.renderError(error.response) })
      })
  }
}
</script>
