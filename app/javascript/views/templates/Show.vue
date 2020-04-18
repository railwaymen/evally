<template>
  <div class="box template">
    <v-form ref="templateForm">
      <v-layout row wrap>
        <v-flex xs12 lg6>
          <div class="template__name">
            <v-text-field
              v-model="templateName"
              :label="$t('views.templates.show.name')"
              :disabled="!template.editable"
              :rules="[vRequired]"
            />
          </div>
        </v-flex>

        <v-flex xs12 lg6>
          <div class="template__destination">
            <v-select
              :items="destinations"
              v-model="templateDestination"
              :label="$t('views.templates.show.destination')"
              :disabled="!template.editable"
              :rules="[vRequired]"
              item-value="value"
              item-text="text"
            />
          </div>
        </v-flex>

        <template v-if="template.isForEmployees">
          <v-flex xs12 lg6>
            <h3 class="evaluation__fullname">
              &lsaquo; {{ $t('views.templates.show.placeholder.name') }} &rsaquo;
            </h3>
            <h4 class="evaluation__position">
              &lsaquo; {{ $t('views.templates.show.placeholder.position') }} &rsaquo;
            </h4>
          </v-flex>

          <v-flex xs6 lg3>
            <div class="date">
              <h5 class="date__value">&lsaquo; date &rsaquo;</h5>
              <h6 class="date__description">{{ $t('views.templates.show.placeholder.hiredOn') }}</h6>
            </div>
          </v-flex>
          <v-flex xs6 lg3>
            <div class="date">
              <h5 class="date__value">&lsaquo; date &rsaquo;</h5>
              <h6 class="date__description">{{ $t('views.templates.show.placeholder.completedAt') }}</h6>
            </div>
          </v-flex>
        </template>

        <v-flex xs12>
          <sections-composer
            v-model="sectionsModels"
            :editable="template.editable"
            :recruitable="template.isForRecruits"
          />
        </v-flex>
      </v-layout>
    </v-form>

    <v-layout row>
      <v-flex xs12 lg6>
        <section-form
          v-if="template.editable"
          v-model="sectionsModels"
          :recruitable="template.isForRecruits"
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
      destinations: 'TemplatesModule/destinations',
      template: 'TemplatesModule/template',
      sections: 'TemplatesModule/sections'
    }),
    sectionsModels: {
      get() {
        return this.sections.models
      },
      set(sections) {
        this.$store.commit('TemplatesModule/SET_SECTIONS', sections)
      }
    },
    templateName: {
      get() {
        return this.template.name
      },
      set(name) {
        this.$store.commit('TemplatesModule/REFRESH_TEMPLATE', { ...this.template, name })
      }
    },
    templateDestination: {
      get() {
        return this.template.destination
      },
      set(destination) {
        this.$store.commit('TemplatesModule/REFRESH_TEMPLATE', { ...this.template, destination })
      }
    }
  },
  watch: {
    $route: {
      immediate: true,
      handler(to, from) {
        this.$store.dispatch('TemplatesModule/fetchTemplate', to.params.id)
      }
    }
  }
}
</script>
