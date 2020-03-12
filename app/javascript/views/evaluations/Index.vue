<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">
        <h2>{{ $t('views.drafts.index.title') }}</h2>
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

        <v-tooltip bottom>
          <template #activator="{ on }">
            <v-btn
              @click="openCompleteForm"
              :disabled="evaluation.isNewRecord"
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
              @click="update"
              :disabled="evaluation.isNewRecord"
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
              @click="reset"
              :disabled="evaluation.isNewRecord"
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
              :disabled="evaluation.isNewRecord"
              v-on="on"
              color="red"
              icon
            >
              <v-icon>mdi-delete-outline</v-icon>
            </v-btn>
          </template>

          <span>{{ $t('shared.tooltips.delete') }}</span>
        </v-tooltip>

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
                    {{ $t('views.drafts.index.instruction') }}
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
import { mapGetters, mapActions } from 'vuex'
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
    toggleSidebar() {
      this.isSidebarVisible = !this.isSidebarVisible
    },
    reset() {
      this.$store.dispatch('DraftsModule/show', this.evaluation.id)
    },
    openCreateForm() {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: CreateForm,
        props: {
          employees: this.employees,
          templates: this.templates
        }
      })
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
    ...mapActions({
      fetchData: 'DraftsModule/index',
      update: 'DraftsModule/update',
    })
  },
  computed: {
    ...mapGetters({
      evaluations: 'DraftsModule/evaluations',
      evaluation: 'DraftsModule/evaluation',
      employees: 'DraftsModule/employees',
      templates: 'DraftsModule/templates',
      loading: 'DraftsModule/loading',
      setting: 'AuthenticationModule/setting'
    })
  },
  created() {
    this.fetchData()
  },
  beforeDestroy() {
    this.$store.commit('DraftsModule/resetState')
  }
}
</script>
