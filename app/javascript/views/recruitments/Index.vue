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
        <v-tooltip
          v-if="$route.name === 'recruitments_path'"
          key="addNew"
          bottom
        >
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

import { RecruitDocument } from '@models/recruit_document'

import BasicTable from '@components/recruitments/BasicTable'
import RecruitmentForm from '@components/recruitments/RecruitmentForm'

export default {
  name: 'RecruitmentsIndex',
  components: { BasicTable },
  methods: {
    ...mapActions({
      fetchData: 'RecruitmentsModule/index'
    })
  },
  computed: {
    ...mapGetters({
      recruitDocuments: 'RecruitmentsModule/recruitDocuments',
      groups: 'RecruitmentsModule/groups',
      statuses: 'RecruitmentsModule/statuses',
      loading: 'RecruitmentsModule/loading'
    })
  },
  created() {
    this.fetchData()
  }
}
</script>
