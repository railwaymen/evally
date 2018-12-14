<template>
  <section class="panel">
    <v-layout row>
      <v-flex>
        <h2 class="panel__heading">{{ $t('evaluations.title') }}</h2>
      </v-flex>

      <v-flex>
        <div class="panel__action-bar">
          <v-tooltip bottom>
            <v-btn @click="build" color="green" slot="activator" icon flat>
              <v-icon>add</v-icon>
            </v-btn>
            <span>{{ $t('evaluations.buttons.add_new') }}</span>
          </v-tooltip>

          <template v-if="draft.isExisting()">
            <v-tooltip v-for="item in menuItems" :key="`item_${item.id}`" bottom>
              <v-btn @click="item.action" :color="item.color" slot="activator" icon flat>
                <v-icon>{{ item.icon }}</v-icon>
              </v-btn>
              <span>{{ $t(`evaluations.buttons.${item.name}`) }}</span>
            </v-tooltip>
          </template>

          <v-tooltip class="divider-before" bottom>
            <v-btn @click="isSidebarVisible = !isSidebarVisible" slot="activator" icon flat>
              <v-icon>{{ isSidebarVisible ? 'visibility_off' : 'visibility' }}</v-icon>
            </v-btn>
            <span>{{ isSidebarVisible ? $t('buttons.hide') : $t('buttons.show') }} sidebar</span>
          </v-tooltip>

        </div>
      </v-flex>
    </v-layout>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout wrap row>
          <v-flex v-if="isSidebarVisible" xs10 offset-xs1 lg3 offset-lg0>
            <evaluation-drafts-box></evaluation-drafts-box>
          </v-flex>

          <v-flex xs12 :lg9="isSidebarVisible" :lg12="!isSidebarVisible">
            <evaluation-box context="evaluation"></evaluation-box>
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapGetters } from 'vuex'

import openerBus from '@/lib/opener_bus'

import CreateEvaluationForm from '@/components/evaluations/CreateEvaluationForm'
import EvaluationBox from '@/components/evaluations/EvaluationBox'
import EvaluationDraftsBox from '@/components/evaluations/EvaluationDraftsBox'

export default {
  name: 'Evaluations',
  components: { CreateEvaluationForm, EvaluationBox, EvaluationDraftsBox },
  data() {
    return {
      isSidebarVisible: true,
      menuItems: [
        { id: 0, name: 'complete', icon: 'how_to_vote', action: this.saveEvaluation, color: 'green' },
        { id: 10, name: 'save_draft', icon: 'save_alt', action: this.saveDraft, color: 'black' },
        { id: 20, name: 'reset', icon: 'restore', action: this.reset, color: 'black' },
        { id: 30, name: 'delete', icon: 'delete', action: this.remove, color: 'red' }
      ]
    }
  },
  methods: {
    reset() {
      this.$store.commit('EvaluationsStore/reset')
    },

    saveDraft() {
      this.draft.updated_at = this.$moment().format()

      this.$store.dispatch('EvaluationsStore/update', { evaluation: this.draft.attributes })
        .then(() => {
          this.flash({ success: this.$t('evaluations.flashes.save.success') })
        })
        .catch(error => {
          this.flash({ error: this.$t('evaluations.flashes.save.error', { reason: this.renderError(error.response) }) })
        })
    },

    build() {
      openerBus.openFormModal({ model: 'draft', action: 'create', maxWidth: 500, redirect: false })
    },

    remove() {
      openerBus.openDestroyModal({ model: 'evaluation', action: 'delete', maxWidth: 500 })
    },

    saveEvaluation() {
      openerBus.openFormModal({ model: 'evaluation', action: 'complete', maxWidth: 500 })
    }
  },
  computed: {
    ...mapGetters({
      draft: 'EvaluationsStore/evaluation'
    })
  },
  created() {
    this.$store.dispatch('EvaluationsStore/index', { state: 'draft' })
      .catch( error => {
        this.flash({ error: this.$t('evaluations.flashes.fetch.error', { reason: this.renderError(error.response) }) })
      })
  },
  beforeDestroy() {
    this.$store.commit('EvaluationsStore/clear')
  }
}
</script>
