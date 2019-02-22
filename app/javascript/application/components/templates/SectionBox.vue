<template>
  <v-flex xs12 :md6="section.isHalfWidth()" :md12="section.isFullWidth()">
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
          <v-btn @click="resize" slot="activator" flat icon>
            <v-icon class="rotateZ90">{{ section.isHalfWidth() ? `unfold_more` : `unfold_less` }}</v-icon>
          </v-btn>
          <span>{{ section.isHalfWidth() ? $t('templates.forms.buttons.full_width') : $t('templates.forms.buttons.half_width') }}</span>
        </v-tooltip>

        <v-btn class="drag-section-btn" flat icon>
          <v-icon>drag_indicator</v-icon>
        </v-btn>

        <v-tooltip bottom>
          <v-btn @click="remove" slot="activator" flat icon>
            <v-icon>delete</v-icon>
          </v-btn>
          <span>{{ $t('templates.forms.buttons.delete') }}</span>
        </v-tooltip>
      </div>

      <group-form :section.sync="section"></group-form>

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
    remove() {
      this.section.set('_destroy', 1)
    },

    resize() {
      this.section.set('width', this.section.isHalfWidth() ? 'full' : 'half')
    }
  },
  computed: {
    ...mapGetters({
      template: 'TemplatesStore/template'
    })
  }
}
</script>
