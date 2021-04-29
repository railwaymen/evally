<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">
        <h2>{{ $t('views.recruitments.index.title') }}</h2>
      </div>

      <div class="panel__nav">
        <v-btn
          :to="{ name: 'recruitments_projects_path' }"
          color="primary"
          exact
          text
        >
          {{ $t('views.recruitments.index.nav.recruitments') }}
        </v-btn>

        <v-btn
          :to="{ name: 'recruitments_path' }"
          color="primary"
          exact
          text
        >
          {{ $t('views.recruitments.index.nav.list') }}
        </v-btn>

        <v-btn
          :to="{ name: 'recruitments_search_path' }"
          color="primary"
          exact
          text
        >
          {{ $t('views.recruitments.index.nav.search') }}
        </v-btn>

        <v-btn
          v-if="recruitDocumentPolicy.canSeeOverview"
          :to="{ name: 'recruitments_overview_path' }"
          color="primary"
          exact
          text
        >
          {{ $t('views.recruitments.index.nav.overview') }}
        </v-btn>

        <v-btn
          v-if="recruitDocumentPolicy.canSeeInbox"
          :to="{ name: 'recruitments_inbox_path' }"
          color="primary"
          exact
          text
        >
          {{ $t('views.recruitments.index.nav.inbox') }}
        </v-btn>
      </div>

      <div class="panel__actions">
        <v-tooltip
          v-if="$route.name === 'recruitments_projects_path'"
          key="addNewProject"
          bottom
        >
          <template #activator="{ on }">
            <v-btn
              @click="openRecruitmentForm"
              v-on="on"
              color="green"
              icon
            >
              <v-icon>mdi-plus</v-icon>
            </v-btn>
          </template>

          <span>{{ $t('shared.tooltips.newRecruitment') }}</span>
        </v-tooltip>

        <v-tooltip
          v-if="$route.name === 'recruitments_path' && recruitDocumentPolicy.canCreate"
          key="addNew"
          bottom
        >
          <template #activator="{ on }">
            <v-btn
              :to="{ name: 'new_recruitment_path' }"
              v-on="on"
              color="green"
              icon
            >
              <v-icon>mdi-plus</v-icon>
            </v-btn>
          </template>

          <span>{{ $t('shared.tooltips.addNew') }}</span>
        </v-tooltip>

        <v-tooltip
           v-if="$route.name === 'recruitment_mailer_path'"
          key="backToProfile"
          bottom
        >
          <template #activator="{ on }">
            <v-btn
              :to="{ name: 'recruitment_path', params: { ...$route.params } }"
              v-on="on"
              color="black"
              exact
              icon
            >
              <v-icon>mdi-account-arrow-left-outline</v-icon>
            </v-btn>
          </template>

          <span>{{ $t('shared.tooltips.backToProfile') }}</span>
        </v-tooltip>

        <template v-if="$route.name === 'recruitment_path'">
          <v-tooltip
            key="mail"
            bottom
          >
            <template #activator="{ on }">
              <v-btn
                v-if="emailPolicy.canSend"
                :to="recruitDocument.mailerPath"
                v-on="on"
                color="black"
                icon
              >
                <v-icon>mdi-email-send-outline</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.sendEmail') }}</span>
          </v-tooltip>

          <v-tooltip
            v-if="recruitDocumentPolicy.canEdit"
            key="edit"
            bottom
          >
            <template #activator="{ on }">
              <v-btn
                :to="recruitDocument.editPath"
                v-on="on"
                color="black"
                icon
              >
                <v-icon>mdi-pencil</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.edit') }}</span>
          </v-tooltip>

          <v-tooltip
            v-if="recruitDocumentPolicy.canRemove"
            key="delete"
            bottom
          >
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
      </div>
    </div>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <basic-table
          v-if="$route.name === 'recruitments_path'"
          :recruitDocuments="recruitDocuments"
          :recruitDocumentPolicy="recruitDocumentPolicy"
          :groups="groups"
          :statuses="statuses"
          :evaluators="evaluators"
          :totalCount="totalCount"
          :loading="fetchLoading"
          @delete="openDeleteConfirm"
        />

        <router-view v-else :key="String($route.params.id)"/>
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapState, mapGetters } from 'vuex'
import { DialogsBus } from '@utils/dialogs_bus'

import BasicTable from '@components/recruitments/BasicTable'
import RecruitmentForm from '@components/recruitments/RecruitmentForm'
import DeleteConfirm from '@components/recruitments/DeleteConfirm'

export default {
  name: 'RecruitmentsIndex',
  components: { BasicTable },
  methods: {
    openRecruitmentForm() {
      DialogsBus.$emit('openConfirmDialog', {
        innerComponent: RecruitmentForm,
        maxWidth: 800
      })
    },
    openDeleteConfirm(id) {
      DialogsBus.$emit('openConfirmDialog', {
        innerComponent: DeleteConfirm,
        props: {
          recruitDocument: this.recruitDocuments.findById(id) || this.recruitDocument
        }
      })
    }
  },
  computed: {
    ...mapState('RecruitDocumentsModule', [
      'recruitDocuments',
      'recruitDocument',
      'groups',
      'statuses',
      'evaluators',
      'totalCount'
    ]),
    ...mapGetters('EmailsModule', [
      'emailPolicy'
    ]),
    ...mapGetters('RecruitDocumentsModule', [
      'recruitDocumentPolicy',
      'fetchLoading'
    ])
  },
  destroyed() {
    this.$store.commit('RecruitDocumentsModule/RESET_STATE')
  }
}
</script>
