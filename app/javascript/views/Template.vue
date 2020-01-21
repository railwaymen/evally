<template>
  <div class="box box--with-content template">
    <v-layout row wrap>
      <v-flex xs12>
        <div class="template__name">
          <v-text-field
            :label="$t('templates.forms.template_name')"
            v-model="template.name"
            :disabled="!template.editable"
          />
        </div>
      </v-flex>

      <v-flex xs12 lg6>
        <div class="employee">
          <h3 class="employee__fullname">
            &lsaquo; {{ $t('templates.placeholders.name') }} &rsaquo;
          </h3>
          <h4 class="employee__position">
            &lsaquo; {{ $t('templates.placeholders.position') }} &rsaquo;
          </h4>
        </div>
      </v-flex>

      <v-flex xs6 lg3>
        <div class="date">
          <h5 class="date__value">&lsaquo; date &rsaquo;</h5>
          <h6 class="date__description">{{ $t('evaluations.forms.hired_at') }}</h6>
        </div>
      </v-flex>
      <v-flex xs6 lg3>
        <div class="date">
          <h5 class="date__value">&lsaquo; date &rsaquo;</h5>
          <h6 class="date__description">{{ $t('evaluations.forms.completed_at') }}</h6>
        </div>
      </v-flex>

      <v-flex xs12>
        <sections-composer
          v-model="sections.models"
          :editable="template.editable"
        />
      </v-flex>

      <v-flex xs12 lg6>
        <section-form
          v-if="template.editable"
          v-model="sections.models"
        />
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

import SectionForm from '@components/templates/SectionForm'
import SectionsComposer from '@components/templates/SectionsComposer'

export default {
  name: 'Template',
  components: { SectionForm, SectionsComposer },
  computed: {
    ...mapGetters({
      template: 'TemplatesModule/template',
      sections: 'TemplatesModule/sections',
    })
  },
  watch: {
    $route: {
      immediate: true,
      handler(to, from) {
        this.$store.dispatch('TemplatesModule/show', to.params.id)
      }
    },
    sections: {
      deep: true,
      handler(newSections, _prevSections) {
        this.$store.commit('TemplatesModule/sectionsList', newSections)
      }
    }
  },
}
</script>
