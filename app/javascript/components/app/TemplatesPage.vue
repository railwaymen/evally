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

            <v-btn color="red" flat>
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
            <templates-list></templates-list>
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

import TemplateBox from './templates/TemplateBox'
import TemplatesList from './templates/TemplatesList'

export default {
  name: 'TemplatesPage',
  components: { TemplateBox, TemplatesList },
  methods: {
    newTemplate() {
      this.$store.commit('SectionsStore/clear')
      this.$store.commit('TemplatesStore/newTemplate')
    },
    edit() {
      this.$store.commit('TemplatesStore/edit')
    },
    save() {
      if (this.template.validate()) {
        setTimeout(() => {
          this.flash({ success: `Template "${this.template.name}" has been succesfully saved.`})
        }, 500)
      }
    }
  },
  computed: {
    ...mapGetters({
      template: 'TemplatesStore/template',
      status: 'TemplatesStore/status'
    })
  }
}
</script>