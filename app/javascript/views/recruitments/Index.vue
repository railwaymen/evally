<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">
        <h2>{{ $t('views.recruitments.index.title') }}</h2>
      </div>

      <div class="panel__nav">
        <v-btn
          color="primary"
          @click="fetchData"
          :to="{ name: 'recruitments_path' }"
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
import { Recruitment } from '@models/recruitment'

import BasicTable from '@components/recruitments/BasicTable'

export default {
  name: 'RecruitmentsIndex',
  components: { BasicTable },
  methods: {
    openCreateForm() {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: RecruitmentForm,
        maxWidth: 800,
        props: {
          employee: new Employee()
        }
      })
    },
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
