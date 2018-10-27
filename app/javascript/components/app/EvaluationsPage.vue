<template>
  <section class="panel">
    <v-layout row>
      <v-flex xs6>
        <h2 class="panel__heading">Evaluations</h2>
      </v-flex>

      <v-flex xs6>
        <div class="panel__action-bar">
          <template v-if="evaluation.isExisting()">
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

            <div class="box pa-4">
              <v-layout>
                <v-flex xs6>
                  <v-btn
                    @click="select('new')"
                    :color="selected === 'new' ? 'primary' : 'grey darken-3'"
                    flat outline block
                  >New</v-btn>
                </v-flex>
                <v-flex xs6>
                  <v-btn
                    @click="select('drafts')"
                    :color="selected === 'drafts' ? 'primary' : 'grey darken-3'"
                    flat outline block
                  >Drafts</v-btn>
                </v-flex>
              </v-layout>
            </div>

            <create-evaluation-form v-if="selected === 'new'"></create-evaluation-form>
            <evaluation-drafts-box v-else></evaluation-drafts-box>
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
  data() {
    return {
      selected: 'new',
      model: 'evaluation'
    }
  },
  methods: {
    select(option) {
      this.selected = option

      if (option === 'new') {
        this.$store.commit('EvaluationsStore/clearDraft')
      }
    },

    reset() {
      this.$store.commit('EvaluationsStore/resetDraft')
    },

    saveDraft() {
      this.$store.dispatch('EvaluationsStore/update', { evaluation: this.evaluation.attributes })
        .then(() => {
          this.flash({ success: `Evaluation has been succefully updated` })
        })
        .catch((error) => {
          this.flash({ error: 'Template cannot be updated due to some error' })
        })
    },

    remove() {
      openerBus.openDestroyModal({ model: this.model, action: 'delete', maxWidth: 500 })
    },

    saveEvaluation() {
      openerBus.openFormModal({ model: this.model, action: 'complete', maxWidth: 500 })
    }
  },
  computed: {
    ...mapGetters({
      evaluation: 'EvaluationsStore/draft'
    })
  }
}
</script>
