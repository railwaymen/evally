<template>
  <div class="box">
    <h2 class="size-27 font-weight-light mb-5">
      {{ $t('views.recruitments.inbox.title') }}
    </h2>

    <v-layout row wrap>
      <v-flex xs12>
        <server-side-table
          :composerClass="composerClass"
          :headers="headers"
          :items="inboundEmails.models"
          :footer-props="{ 'items-per-page-options': [50, 100, 200] }"
          :server-items-length="totalCount"
          :loading="loading"
          @change:options="fetchInboundEmails"
        >
          <template #item.parsed="{ item }">
            <v-icon v-if="item.parsed" color="success">mdi-check</v-icon>
            <v-icon v-else color="error">mdi-close</v-icon>
          </template>

          <template #item.created_at="{ item }">
            {{ item.createdAt }}
          </template>
        </server-side-table>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapState } from 'vuex'

import ServerSideTable from '@components/shared/ServerSideTable'

import InboxTableComposer from '@utils/data_tables/inbox_table_composer'

export default {
  name: 'InboxView',
  components: { ServerSideTable },
  data() {
    return {
      composerClass: InboxTableComposer,
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
    fetchInboundEmails(query) {
      this.$store.dispatch('RecruitmentsInboxModule/fetchData', query)
    }
  },
  computed: {
    ...mapState('RecruitmentsInboxModule', [
      'inboundEmails',
      'totalCount',
      'loading'
    ])
  }
}
</script>
