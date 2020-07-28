<template>
  <div class="box">
    <h2 class="size-27 font-weight-light mb-5">
      {{ $t('views.recruitments.inbox.title') }}
    </h2>

    <v-layout row wrap>
      <v-flex xs12>
        <v-data-table
          :headers="headers"
          :items="inboundEmails.models"
          :server-items-length="totalCount"
          :footer-props="{ 'items-per-page-options': [25, 50, 100] }"
          :loading="loading"
          @update:options="setQuery"
        >
          <template #item.parsed="{ item }">
            <v-icon v-if="item.parsed" color="success">mdi-check</v-icon>
            <v-icon v-else color="error">mdi-close</v-icon>
          </template>

          <template #item.created_at="{ item }">
            {{ item.createdAt }}
          </template>
        </v-data-table>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapState } from 'vuex'

export default {
  name: 'InboxView',
  props: {

  },
  data() {
    return {
      headers: [
        {
          text: this.$t('components.recruitments.table.cols.source'),
          sortable: false,
          value: 'source'
        },
        {
          text: this.$t('components.recruitments.table.cols.subject'),
          sortable: false,
          value: 'subject'
        },
        {
          text: this.$t('components.recruitments.table.cols.parsed'),
          value: 'parsed'
        },
        {
          text: this.$t('components.recruitments.table.cols.status'),
          value: 'status'
        },
        {
          text: this.$t('components.recruitments.table.cols.receivedAt'),
          value: 'created_at'
        }
      ]
    }
  },
  methods: {
    setQuery(data) {
      const { sortBy, sortDesc } = data

      this.$router.replace({
        name: 'recruitments_inbox_path',
        query: {
          page: data.page,
          per_page: data.itemsPerPage,
          sort_by: sortBy[0] || 'created_at',
          sort_dir: sortDesc[0] || !sortBy[0] ? 'desc' : 'asc'
        }
      })
    }
  },
  computed: {
    ...mapState('RecruitmentsInboxModule', [
      'inboundEmails',
      'totalCount',
      'loading'
    ])
  },
  watch: {
    $route: {
      immediate: true,
      handler(to) {
        if (to.name === 'recruitments_inbox_path') {
          this.$store.dispatch('RecruitmentsInboxModule/fetchData', to.query)
        }
      }
    }
  },
}
</script>
