<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">
        <h2>{{ $t('views.recruitments.index.title') }}</h2>
      </div>

      <div class="panel__nav">
        <v-btn
          :to="{ name: 'recruitments_path'}"
          color="primary"
          exact
          text
        >
          {{ $t('views.recruitments.index.nav.list') }}
        </v-btn>
      </div>

      <div class="panel__actions">
        <template v-if="$route.name === 'recruitments_path'">
          <v-tooltip bottom key="addNew" >
            <template #activator="{ on }">
              <v-btn
                :to="{ name: 'new_recruitment_path'}"
                v-on="on"
                color="green"
                icon
              >
                <v-icon>mdi-plus</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.addNew') }}</span>
          </v-tooltip>
        </template>

        <template v-if="$route.name === 'recruitment_path'">
          <v-tooltip bottom key="add_evaluation">
            <template #activator="{ on }">
              <v-btn
                @click="openCreateEvaluationForm"
                v-on="on"
                color="green"
                icon
              >
                <v-icon>mdi-clipboard-plus-outline</v-icon>
              </v-btn>
            </template>

            <span>Add Evaluation</span>
          </v-tooltip>
        </template>
      </div>
    </div>

      <div class="panel__content">
        <v-container grid-list-lg fluid>
          <basic-table
            v-if="$route.name === 'recruitments_path'"
            :recruitDocuments="recruitDocuments"
            :groups="groups"
            :statuses="statuses"
            :loading="loading"
          />

          <router-view v-else />
        </v-container>
      </div>
  </section>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import { DialogsBus } from '@utils/dialogs_bus'

import { RecruitDocument } from '@models/recruit_document'

import CreateEvaluationForm from '@components/recruitments/CreateEvaluationForm'
import BasicTable from '@components/recruitments/BasicTable'
import RecruitmentForm from '@components/recruitments/RecruitmentForm'

export default {
  name: 'RecruitmentsIndex',
  components: { CreateEvaluationForm, BasicTable },
  methods: {
    openCreateEvaluationForm() {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: CreateEvaluationForm,
        props: {
          templates: this.templates
        }
      })
    },
    ...mapActions({
      fetchData: 'RecruitDocumentsModule/index'
    })
  },
  computed: {
    ...mapGetters({
      recruitDocuments: 'RecruitDocumentsModule/recruitDocuments',
      templates: 'RecruitDocumentsModule/templates',
      groups: 'RecruitDocumentsModule/groups',
      statuses: 'RecruitDocumentsModule/statuses',
      loading: 'RecruitDocumentsModule/loading'
    })
  },
  created() {
    this.fetchData()
  }
}
</script>
