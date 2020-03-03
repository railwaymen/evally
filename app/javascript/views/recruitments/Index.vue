<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">

        <h2 v-if="$route.name === 'recruitments_path'">{{ $t('views.recruitments.index.title') }}</h2>
        <router-view v-else />
      </div>
      <v-container grid-list-lg fluid>
        <basic-table
          v-if="$route.name === 'recruitments_path'"
          :recruitments="recruitments"
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
import BasicTable from '@components/recruitments/BasicTable'
import { Recruitment } from '@models/recruitment'

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
      recruitments: 'RecruitmentsModule/recruitments',
      loading: 'RecruitmentsModule/loading'
    })
  }
}
</script>
