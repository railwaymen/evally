<template>
  <div class="box">
    <v-layout row wrap>
      <v-flex xs12>
        <v-data-table
          :headers="headers"
          :items="inboundEmails.models"
          @update:options="print"
        >
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
          value: 'source'
        },
        {
          text: this.$t('components.recruitments.table.cols.subject'),
          value: 'subject'
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
    print(x) {
      console.log(x)
    }
  },
  computed: {
    ...mapState('RecruitmentsInboxModule', [
      'inboundEmails'
    ])
  },
  watch: {
    $route: {
      immediate: true,
      handler(to) {
        if (to.name === 'recruitments_inbox_path') {
          this.$store.dispatch('RecruitmentsInboxModule/fetchData')
        }
      }
    }
  },
}
</script>
