<template>
  <div class="box template">
    <div class="template__autosave autosave mb-2">
      <div class="autosave__control">
        <v-switch
          v-model="autosaving"
          :label="$t('views.templates.show.autosave.status', { status: autosaving ? 'ON' : 'OFF' })"
          inset
        />
      </div>

      <div v-if="autosave.success" class="autosave__info green--text">
        {{ $t('views.templates.show.autosave.success', { datetime: autosave.performedAt }) }}
      </div>

      <div v-if="autosave.failed" class="autosave__info red--text">
        {{ $t('views.templates.show.autosave.failure', { datetime: autosave.performedAt }) }}
      </div>
    </div>

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
import { mapActions, mapState } from 'vuex'

import SectionForm from '@components/templates/SectionForm'
import SectionsComposer from '@components/templates/SectionsComposer'

import { Autosave } from '@models/autosave'

export default {
  name: 'Template',
  components: { SectionForm, SectionsComposer },
  data() {
    return {
      autosaving: true,
      autosave: new Autosave()
    }
  },
  methods: {
    ...mapActions('TemplatesModule', [
      'updateTemplate'
    ]),
    save() {
      if (!this.template.editable) return

      this.updateTemplate()
        .then(() => this.autosave.touch())
        .catch(() => this.autosave.fail())
    }
  },
  computed: {
    ...mapState('TemplatesModule', [
      'destinations',
      'template',
      'sections'
    ]),
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
    autosaving: {
      immediate: true,
      handler(val) {
        val ? this.autosave.enable(this.save) : this.autosave.disable()
      }
    },
    $route: {
      immediate: true,
      handler(to) {
        this.$store.dispatch('TemplatesModule/fetchTemplate', to.params.id)
      }
    }
  },
  beforeDestroy() {
    this.autosave.disable()
  }
}
</script>
