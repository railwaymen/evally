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
        <v-tooltip bottom key="addNew" >
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

        <template v-if="$route.name === 'recruitment_path'">
          <v-tooltip key="delete" bottom >
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
import { mapGetters } from 'vuex'
import { DialogsBus } from '@utils/dialogs_bus'

import { RecruitDocument } from '@models/recruit_document'

import BasicTable from '@components/recruitments/BasicTable'
import DeleteConfirm from '@components/recruitments/DeleteConfirm'

export default {
  name: 'RecruitmentsIndex',
  components: { BasicTable },
  methods: {
    openDeleteConfirm() {
      DialogsBus.$emit('openConfirmDialog', {
        innerComponent: DeleteConfirm
      })
    }
  },
  computed: {
    ...mapGetters({
      recruitDocuments: 'RecruitDocumentsModule/recruitDocuments',
      groups: 'RecruitDocumentsModule/groups',
      statuses: 'RecruitDocumentsModule/statuses',
      loading: 'RecruitDocumentsModule/loading'
    })
  },
  watch: {
    $route: {
      immediate: true,
      handler(to) {
        if (to.name === 'recruitments_path') {
          this.$store.dispatch('RecruitDocumentsModule/index')
        }
      }
    }
  },
  beforeDestroy() {
    this.$store.commit('RecruitDocumentsModule/resetState')
  }
}
</script>
