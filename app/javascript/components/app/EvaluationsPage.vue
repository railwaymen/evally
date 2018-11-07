<template>
  <section class="panel">
    <v-layout row>
      <v-flex xs6>
        <h2 class="panel__heading">Evaluations</h2>
      </v-flex>

      <v-flex xs6>
        <div class="panel__action-bar">
          <v-btn @click="build" color="green" flat>
            <v-icon>add</v-icon> New evaluation
          </v-btn>

          <template v-if="draft.isExisting()">
            <v-btn @click="saveEvaluation" color="green" flat>
              <v-icon>save_alt</v-icon> Save completed
            </v-btn>
            <v-btn @click="saveDraft" flat>
              <v-icon>how_to_vote</v-icon> Save draft
            </v-btn>
            <v-btn @click="reset" flat>
              <v-icon>restore</v-icon> Reset
            </v-btn>
            <v-btn @click="remove" color="red" flat>
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
            <evaluation-drafts-box></evaluation-drafts-box>
          </v-flex>

          <v-flex xs9>
            <evaluation-box context="evaluation"></evaluation-box>
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapGetters } from 'vuex'

import openerBus from '../../lib/opener_bus'

import CreateEvaluationForm from '../forms/CreateEvaluationForm'
import EvaluationBox from './evaluations/EvaluationBox'
import EvaluationDraftsBox from './evaluations/EvaluationDraftsBox'

export default {
  name: 'EvaluationsPage',
  components: { CreateEvaluationForm, EvaluationBox, EvaluationDraftsBox },
  methods: {
    reset() {
      this.$store.commit('EvaluationsStore/resetDraft')
    },

    saveDraft() {
      this.draft.updated_at = this.$moment().format()

      this.$store.dispatch('EvaluationsStore/update', { evaluation: this.draft.attributes })
        .then(() => {
          this.flash({ success: `Evaluation has been succefully updated` })
        })
        .catch(error => {
          this.flash({ error: 'Evaluation cannot be updated due to some error: ' + this.renderError(error.response) })
        })
    },

    build() {
      this.$store.commit('EvaluationsStore/clearDraft')
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
      draft: 'EvaluationsStore/draft'
    })
  },
  created() {
    this.$store.dispatch('EvaluationsStore/index')
      .catch( error => {
        this.flash({ error: 'Draft evaluations cannot be loaded due to some error: ' + this.renderError(error.response) })
      })
  }
}
</script>
