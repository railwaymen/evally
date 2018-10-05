<template>
  <section class="panel">
    <v-layout row>
      <v-flex xs6>
        <h2 class="panel__heading">Templates</h2>
      </v-flex>

      <v-flex>
        <div class="panel__action-bar">
          <v-btn color="green" flat>
            <v-icon>add</v-icon> New template
          </v-btn>

          <template v-if="template.isExisting()">
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
            <template-form></template-form>
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapGetters } from 'vuex'

import TemplateForm from './templates/TemplateForm'
import TemplatesList from './templates/TemplatesList'

export default {
  name: 'TemplatesPage',
  components: { TemplateForm, TemplatesList },
  methods: {
    edit() {
      this.$store.commit('TemplatesStore/edit')
    },
    save() {
      setTimeout(() => {
        this.flash({ success: `Template "${this.template.name}" has been succesfully saved.`})
      }, 500)
    }
  },
  computed: {
    ...mapGetters({
      template: 'TemplatesStore/template'
    })
  }
}
</script>