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
      </div>
    </div>

      <div class="panel__content">
        <v-container grid-list-lg fluid>
          <basic-table
            v-if="$route.name === 'recruitments_path'"
            :recruitDocuments="recruitDocuments"
            :loading="loading"
          />

          <router-view v-else />
        </v-container>
      </div>


  </section>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'

import BasicTable from '@components/recruitments/BasicTable'

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
      loading: 'RecruitmentsModule/loading'
    })
  },
  created() {
    this.fetchData()
  }
}
</script>
