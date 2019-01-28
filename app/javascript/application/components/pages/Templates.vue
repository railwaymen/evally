<template>
  <section class="panel">
    <v-layout row>
      <v-flex>
        <h2 class="panel__heading">{{ $t('templates.title') }}</h2>
      </v-flex>

      <v-flex>
        <div class="panel__action-bar">
          <v-tooltip bottom>
            <v-btn @click="addNew" color="green" slot="activator" icon flat>
              <v-icon>add</v-icon>
            </v-btn>
            <span>{{ $t('templates.buttons.add_new') }}</span>
          </v-tooltip>

          <v-tooltip bottom v-if="template.editable">
            <v-btn @click="save" slot="activator" icon flat>
              <v-icon>save_alt</v-icon>
            </v-btn>
            <span>{{ $t('templates.buttons.save') }}</span>
          </v-tooltip>

          <template v-if="template.isExisting()">
            <v-tooltip bottom>
              <v-btn @click="edit" :disabled="template.editable" slot="activator" icon flat>
                <v-icon>edit</v-icon>
              </v-btn>
              <span>{{ $t('templates.buttons.edit') }}</span>
            </v-tooltip>

            <v-tooltip bottom>
              <v-btn @click="remove" color="red" slot="activator" icon flat>
                <v-icon>delete</v-icon>
              </v-btn>
              <span>{{ $t('templates.buttons.delete') }}</span>
            </v-tooltip>
          </template>
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
            <v-form ref="templateForm">
              <template-box></template-box>
            </v-form>
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
    addNew() {
      this.$store.commit('SectionsStore/clear')
      this.$store.commit('TemplatesStore/one', { editable: true })
    },

    edit() {
      this.template.set('editable', true)
    },

    save() {
      if (!this.$refs.templateForm.validate()) return
      this.template.sections_attributes = this.sections.map(section => section.attributes)

      if (this.template.isDraft()) {
        this.template.set('state', 'created')

        this.$store.dispatch('TemplatesStore/create', { template: this.template })
          .then(() => {
            this.flash({ success: this.$root.$t('templates.flashes.create.success') })
            this.template.set('editable', false)
          })
          .catch(error => {
            this.flash({ error: this.$root.$t('templates.flashes.create.error', { reason: this.renderError(error.response) }) })
          })
      } else if (this.template.isCreated()) {
        this.$store.dispatch('TemplatesStore/update', { template: this.template })
          .then(() => {
            this.flash({ success: this.$root.$t('templates.flashes.save.success') })
            this.template.set('editable', false)
          })
          .catch(error => {
            this.flash({ error: this.$root.$t('templates.flashes.save.error', { reason: this.renderError(error.response) }) })
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
        this.flash({ error: this.$root.$t('templates.flashes.fetch.error', { reason: this.renderError(error.response) }) })
      })
  },

  beforeDestroy() {
    this.$store.commit('TemplatesStore/clear')
  }
}
</script>
