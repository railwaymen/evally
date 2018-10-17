<template>
  <v-flex :xs6="section.width === 'half'" :xs12="section.width === 'full'">
    <div class="section-form-box">
      <h5 class="section-form-box__heading">
        <span class="section-form-box__heading-content" v-if="template.editable">
          <v-text-field
            v-model="section.name"
            :error-messages="section.errors.name"
            label="Section title"
            outline
          ></v-text-field>
        </span>

        <span class="section-form-box__heading-content" v-else>{{ section.name }}</span>
      </h5>

      <div class="section-form-box__actions" v-if="template.editable">
        <v-btn @click="remove(section)" flat icon>
          <v-icon>delete</v-icon>
        </v-btn>
      </div>

      <group-form :skills="section.skills" :group="section.group" :sectionId="section.id || section.tempId"></group-form>

    </div>
  </v-flex>
</template>

<script>
import { mapGetters } from 'vuex'

import GroupForm from './GroupForm'

export default {
  name: 'SectionBox',
  components: { GroupForm },
  props: ['section'],
  methods: {
    remove(section) {
      this.$store.commit('SectionsStore/markAsRemoved', section.id || section.tempId)
    }
  },
  computed: {
    ...mapGetters({
      template: 'TemplatesStore/template'
    })
  }
}
</script>
