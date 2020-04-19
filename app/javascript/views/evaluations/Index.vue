<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">
        <h2>{{ $t('views.evaluations.index.title') }}</h2>
      </div>

      <div class="panel__actions">
        <v-tooltip bottom>
          <template #activator="{ on }">
            <v-btn
              @click="openCreateForm"
              v-on="on"
              color="green"
              icon
            >
              <v-icon>mdi-plus</v-icon>
            </v-btn>
          </template>

          <span>{{ $t('shared.tooltips.addNew') }}</span>
        </v-tooltip>

        <template v-if="evaluation.isPersisted">
          <v-tooltip bottom>
            <template #activator="{ on }">
              <v-btn
                @click="openCompleteForm"
                v-on="on"
                color="green"
                icon
              >
                <v-icon>mdi-bookmark-check-outline</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.complete') }}</span>
          </v-tooltip>

          <v-tooltip bottom>
            <template #activator="{ on }">
              <v-btn
                @click="updateEvaluation"
                v-on="on"
                color="black"
                icon
              >
                <v-icon>mdi-content-save-outline</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.save') }}</span>
          </v-tooltip>

          <v-tooltip bottom>
            <template #activator="{ on }">
              <v-btn
                @click="fetchEvaluation(evaluation.id)"
                v-on="on"
                color="black"
                icon
              >
                <v-icon>mdi-restore</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.reset') }}</span>
          </v-tooltip>

          <v-tooltip bottom>
            <template #activator="{ on }">
              <v-btn
                @click="openDeleteConfirm"
                v-on="on"
                color="red"
                icon
              >
                <v-icon>mdi-delete-outline</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.delete') }}</span>
          </v-tooltip>
        </template>

        <v-tooltip bottom>
          <template #activator="{ on }">
            <v-btn
              @click="toggleSidebar"
              v-on="on"
              color="black"
              icon
            >
              <v-icon>{{ isSidebarVisible ? 'mdi-eye-off-outline' : 'mdi-eye-outline' }}</v-icon>
            </v-btn>
          </template>

          <span>
            {{ isSidebarVisible ? $t('shared.tooltips.hideSidebar') : $t('shared.tooltips.showSidebar') }}
          </span>
        </v-tooltip>
      </div>
    </div>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout wrap row>
          <v-flex v-show="isSidebarVisible" xs10 offset-xs1 lg3 offset-lg0>
            <search-list
              :evaluations="evaluations"
              :loading="loading"
            />
          </v-flex>

          <v-flex xs12 :lg9="isSidebarVisible" :lg12="!isSidebarVisible">
            <div v-if="$route.name === 'evaluation_drafts_path'" class="box">
              <v-layout row>
                <v-flex xs12>
                  <h4 class="box__header">
                    {{ $t('views.evaluations.index.instruction') }}
                  </h4>
                </v-flex>
              </v-layout>
            </div>

            <router-view v-else />
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapActions, mapState } from 'vuex'
import { DialogsBus } from '@utils/dialogs_bus'

import CompleteForm from '@components/evaluations/CompleteForm'
import CreateForm from '@components/evaluations/CreateForm'
import DeleteConfirm from '@components/evaluations/DeleteConfirm'
import SearchList from '@components/evaluations/SearchList'

export default {
  name: 'EvaluationsIndex',
  components: { SearchList },
  data() {
    return {
      isSidebarVisible: true
    }
  },
  methods: {
    ...mapActions('EvaluationEmployablesModule', [
      'fetchEvaluations',
      'fetchEvaluation',
      'newEvaluation',
      'updateEvaluation'
    ]),
    openCreateForm() {
      this.newEvaluation()
        .then(
          () => DialogsBus.$emit('openFormsDialog', {
            innerComponent: CreateForm,
            props: {
              employees: this.employees,
              templates: this.templates
            }
          })
        )
    },
    openCompleteForm() {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: CompleteForm,
        props: {
          date: this.$moment().add(this.setting.default_next_evaluation_time, 'M').startOf('month')
        }
      })
    },
    openDeleteConfirm() {
      DialogsBus.$emit('openConfirmDialog', {
        innerComponent: DeleteConfirm
      })
    },
    toggleSidebar() {
      this.isSidebarVisible = !this.isSidebarVisible
    }
  },
  computed: {
    ...mapState('EvaluationEmployablesModule', [
      'evaluations',
      'evaluation',
      'employees',
      'templates',
      'loading'
    ]),
    ...mapState('AuthenticationModule', [
      'setting'
    ])
  },
  created() {
    this.fetchEvaluations()
  },
  destroyed() {
    this.$store.commit('EvaluationEmployablesModule/RESET_STATE')
  }
}
</script>
