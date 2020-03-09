<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">
        <h2>{{ $t('views.recruitments.index.title') }}</h2>
      </div>

      <div class="panel__nav">
        <v-btn
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
              <router-link :to="{ name: 'new_recruitment_path'}">
              <v-btn
                v-on="on"
                color="green"
                icon
              >
                <v-icon>mdi-plus</v-icon>
              </v-btn>
              </router-link>
            </template>

            <span>{{ $t('shared.tooltips.addNew') }}</span>
          </v-tooltip>

          <v-tooltip bottom key="add_evaluation">
            <template #activator="{ on }">
              <v-btn
                @click="openAddEvaluationForm"
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

import AddEvaluationForm from '@components/recruitments/AddEvaluationForm'
import BasicTable from '@components/recruitments/BasicTable'
import RecruitmentForm from '@components/recruitments/RecruitmentForm'

export default {
  name: 'RecruitmentsIndex',
  components: { AddEvaluationForm, BasicTable },
  methods: {
    openAddEvaluationForm() {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: AddEvaluationForm,
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
