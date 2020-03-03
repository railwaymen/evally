<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">

        <h2 v-if="$route.name === 'candidates_path'">{{ $t('views.candidates.index.title') }}</h2>
        <router-view v-else />
      </div>
      <v-container grid-list-lg fluid>
        <basic-table
          v-if="$route.name === 'candidates_path'"
          :candidates="candidates"
          :loading="loading"
          :editable="false"
        />

        <router-view v-else />
      </v-container>

    </div>
  </section>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import BasicTable from '@components/candidates/BasicTable'
import { Candidate } from '@models/candidate'

export default {
  name: 'CandidatesIndex',
  components: { BasicTable },
  methods: {
    ...mapActions({
      fetchData: 'CandidatesModule/index'
    })
  },
  computed: {
    ...mapGetters({
      candidates: 'CandidatesModule/candidates',
      loading: 'CandidatesModule/loading'
    })
  }
}
</script>
