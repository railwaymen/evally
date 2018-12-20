<template>
  <v-flex xs12 :md6="isHalfWidth" :md12="isFullWidth">
    <div class="section-box">
      <h5 class="section-box__heading">
        <span v-if="template.editable">
          <v-text-field
            v-model="section.name"
            :rules="[vRequired, vIsString]"
            :label="$t('templates.forms.section_title')"
            outline
          ></v-text-field>
        </span>

        <span v-else>{{ section.name }}</span>
      </h5>

      <div class="section-box__actions" v-if="template.editable">
        <v-tooltip bottom>
          <v-btn @click="resize(section)" slot="activator" flat icon>
            <v-icon class="rotateZ90">{{ isHalfWidth ? `unfold_more` : `unfold_less` }}</v-icon>
          </v-btn>
          <span>{{ isHalfWidth ? $t('templates.forms.buttons.full_width') : $t('templates.forms.buttons.half_width') }}</span>
        </v-tooltip>

        <v-btn class="drag-section-btn" flat icon>
          <v-icon>drag_indicator</v-icon>
        </v-btn>

        <v-tooltip bottom>
          <v-btn @click="remove(section)" slot="activator" flat icon>
            <v-icon>delete</v-icon>
          </v-btn>
          <span>{{ $t('templates.forms.buttons.delete') }}</span>
        </v-tooltip>
      </div>

      <group-form :skills="section.skills" :group="section.group" :sectionId="section.id || section.tempId"></group-form>

    </div>
  </v-flex>
</template>

<script>
import { mapGetters } from 'vuex'

import GroupForm from '@/components/templates/GroupForm'

export default {
  name: 'SectionBox',
  components: { GroupForm },
  props: ['section'],
  methods: {
    remove(section) {
      this.$store.commit('SectionsStore/markAsRemoved', section.id || section.tempId)
    },

    resize(section) {
      let width = section.width === 'half' ? 'full' : 'half'
      this.$store.commit('SectionsStore/resize', { id: section.id || section.tempId, width: width })
    }
  },
  computed: {
    ...mapGetters({
      template: 'TemplatesStore/template'
    }),

    isHalfWidth() {
      return this.section.width === 'half'
    },

    isFullWidth() {
      return this.section.width === 'full'
    }
  }
}
</script>
