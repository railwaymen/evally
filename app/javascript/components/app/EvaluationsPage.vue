<template>
  <section class="panel">
    <v-layout row>
      <v-flex xs6>
        <h2 class="panel__heading">Evaluations</h2>
      </v-flex>

      <v-flex xs6>
        <div class="panel__action-bar">
          <template>
            <v-btn color="green" flat>
              <v-icon>save_alt</v-icon> Save
            </v-btn>
            <v-btn flat>
              <v-icon>how_to_vote</v-icon> Save draft
            </v-btn>
            <v-btn color="red" flat>
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

            <div class="box px-3">
              <v-layout>
                <v-flex xs6>
                  <v-btn 
                    @click="newSelected = true"
                    :color="newSelected ? 'primary' : ''"
                    flat outline block
                  >New</v-btn>
                </v-flex>
                <v-flex xs6>
                  <v-btn
                    @click="newSelected = false"
                    :color="newSelected ? '' : 'primary'"
                    flat outline block
                  >Drafts</v-btn>
                </v-flex>
              </v-layout>
            </div>

            <create-evaluation-form v-if="newSelected"></create-evaluation-form>
            <evaluation-drafts-box v-else></evaluation-drafts-box>
          </v-flex>

          <v-flex xs9>
            <evaluation-box></evaluation-box>
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import CreateEvaluationForm from '../forms/CreateEvaluationForm'
import EvaluationBox from './evaluations/EvaluationBox'
import EvaluationDraftsBox from './evaluations/EvaluationDraftsBox'

export default {
  name: 'EvaluationsPage',
  components: { CreateEvaluationForm, EvaluationBox, EvaluationDraftsBox },
  data() {
    return {
      newSelected: true
    }
  }
}
</script>
