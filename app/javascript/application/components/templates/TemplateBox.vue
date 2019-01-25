<template>
  <div class="box box--with-content template">
    <v-layout v-if="template.isVisible()" row wrap>
      <v-flex xs12>
        <div class="template__name">
          <v-text-field
            :label="$t('templates.forms.template_name')"
            v-model="template.name"
            :disabled="!template.editable"
            :rules="[vRequired]"
          ></v-text-field>
        </div>
      </v-flex>
      <v-flex xs12 lg6>
        <div class="employee">
          <h3 class="employee__fullname">&lsaquo; {{ $t('templates.placeholders.name') }} &rsaquo;</h3>
          <h4 class="employee__position">&lsaquo; {{ $t('templates.placeholders.position') }} &rsaquo;</h4>
        </div>

      </v-flex>

      <v-flex xs4 lg2>
        <div class="date">
          <h5 class="date__value">&lsaquo; date &rsaquo;</h5>
          <h6 class="date__description">{{ $t('evaluations.forms.hired_at') }}</h6>
        </div>
      </v-flex>
      <v-flex xs4 lg2>
        <div class="date">
          <h5 class="date__value">&lsaquo; date &rsaquo;</h5>
          <h6 class="date__description">{{ $t('evaluations.forms.next_review') }}</h6>
        </div>
      </v-flex>
      <v-flex xs4 lg2>
        <div class="date">
          <h5 class="date__value">&lsaquo; date &rsaquo;</h5>
          <h6 class="date__description">{{ $t('evaluations.forms.completed_at') }}</h6>
        </div>
      </v-flex>

      <v-flex xs12>
        <draggable element="v-layout" :list="sections.models" :options="draggableOptions" @end="updatePositions" row wrap>
          <section-box
            v-for="(section, index) in sections.models"
            v-show="!section._destroy"
            :key="index"
            :section.sync="section"
            class="drag-section"
          ></section-box>
        </draggable>
      </v-flex>

      <new-section-form v-if="template.editable"></new-section-form>
    </v-layout>

    <v-layout row v-else>
      <v-flex xs12>
        <h4 class="no-content__header no-content__header--large">{{ $t('templates.messages.select') }}</h4>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

import Draggable from 'vuedraggable'

import NewSectionForm from '@/components/templates/NewSectionForm'
import SectionBox from '@/components/templates/SectionBox'

export default {
  name: 'EmployeeCard',
  components: { Draggable, NewSectionForm, SectionBox },
  data() {
    return {
      draggableOptions: {
        draggable: '.drag-section',
        handle: '.drag-section-btn',
        animation: 300
      }
    }
  },
  methods: {
    updatePositions() {
      this.sections.map((section, index) => section.set('position', index))
      this.$store.commit('SectionsStore/many', this.sections.models)
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
