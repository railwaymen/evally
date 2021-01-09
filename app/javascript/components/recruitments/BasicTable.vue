<template>
  <div class="box">
    <server-side-table
      :composerClass="composerClass"
      :headers="headers"
      :items="recruitDocuments.models"
      :footer-props="{ 'items-per-page-options': [25, 50, 100] }"
      :server-items-length="totalCount"
      :loading="loading"
      @change:options="fetchRecruitDocuments"
    >
      <template #search="{ options, searchBy }">
        <v-flex xs12 lg3>
          <v-text-field
            :value="options.search"
            @input="searchBy"
            append-icon="mdi-magnify"
            :label="$t('components.recruitments.table.search')"
            solo
          />
        </v-flex>
      </template>

      <template #filters="{ options }">
        <v-flex xs12 lg3>
          <v-select
            v-model="options.group"
            :items="groups"
            :label="$t('components.recruitments.table.groupFilter')"
            clearable
            chips
            solo
          />
        </v-flex>

        <v-flex xs12 lg3>
          <status-select
            v-model="options.status"
            :items="statuses"
            :label="$t('components.recruitments.table.statusFilter')"
            clearable
            solo
          />
        </v-flex>

        <v-flex xs12 lg3>
          <v-select
            v-model="options.evaluatorToken"
            :items="evaluators.models"
            :label="$t('components.recruitments.table.evaluatorFilter')"
            item-value="email_token"
            item-text="fullname"
            clearable
            chips
            solo
          />
        </v-flex>
      </template>

      <template #item.action="{ item }">
        <v-tooltip
          v-if="recruitDocumentPolicy.canRemove"
          bottom
        >
          <template #activator="{ on }">
            <v-icon
              @click="$emit('delete', item.id)"
              v-on="on"
              class="mx-2"
              color="red"
              small
            >
              mdi-delete-outline
            </v-icon>
          </template>

          <span>{{ $t('shared.tooltips.delete') }}</span>
        </v-tooltip>

        <v-tooltip
          v-if="recruitDocumentPolicy.canEdit"
          bottom
        >
          <template #activator="{ on }">
            <v-icon
              @click="$router.push(item.editPath)"
              v-on="on"
              class="mx-2"
              small
            >
              mdi-pencil
            </v-icon>
          </template>

          <span>{{ $t('shared.tooltips.edit') }}</span>
        </v-tooltip>
      </template>

      <template #item.last_name="{ item }">
        <router-link :to="item.showPath">
          {{ item.fullname }}
        </router-link>
      </template>

      <template #item.status="{ item }">
        <v-chip
          :color="item.status.color"
          dark
          small
          label
        >
          <strong>{{ item.status.label }}</strong>
        </v-chip>
      </template>

      <template #item.evaluator_fullname="{ item }">
        {{ item.evaluator_fullname || '---' }}
      </template>

      <template #item.received_at="{ item }">
        {{ item.receivedAt }}
      </template>

      <template #item.accept_current_processing="{ item }">
        <v-icon>{{ item.accept_current_processing ? 'mdi-check' : 'mdi-minus' }}</v-icon>
      </template>

      <template #item.accept_future_processing="{ item }">
        <v-icon>{{ item.accept_future_processing ? 'mdi-check' : 'mdi-minus' }}</v-icon>
      </template>
    </server-side-table>
  </div>
</template>

<script>
import RecruitDocumentPolicy from '@policies/recruit_document_policy'

import { RecruitDocumentsList } from '@models/recruit_document'
import { UsersList } from '@models/user'

import StatusSelect from '@components/recruitments/StatusSelect'
import ServerSideTable from '@components/shared/ServerSideTable'

import RecruitmentsTableComposer from '@utils/data_tables/recruitments_table_composer'

export default {
  name: 'BasicTable',
  components: { StatusSelect, ServerSideTable },
  props: {
    loading: {
      type: Boolean,
      required: true,
      default: true
    },
    recruitDocuments: {
      type: RecruitDocumentsList,
      required: true,
      default: () => new RecruitDocumentsList()
    },
    evaluators: {
      type: UsersList,
      required: true,
      default: () => new UsersList()
    },
    recruitDocumentPolicy: {
      type: RecruitDocumentPolicy,
      required: true,
      default: () => new RecruitDocumentPolicy()
    },
    groups: {
      type: Array,
      required: true,
      default: () => []
    },
    statuses: {
      type: Array,
      required: true,
      default: () => []
    },
    totalCount: {
      type: Number,
      required: true,
      default: 0
    }
  },
  data() {
    return {
      composerClass: RecruitmentsTableComposer,
      headers: [
        {
          sortable: false,
          value: 'action',
        },
        {
          text: this.$t('components.employees.table.cols.name'),
          value: 'last_name'
        },
        {
          text: this.$t('components.recruitments.table.cols.email'),
          value: 'email'
        },
        {
          text: this.$t('components.recruitments.table.cols.group'),
          value: 'group'
        },
        {
          text: this.$t('components.recruitments.table.cols.position'),
          value: 'position'
        },
        {
          text: this.$t('components.recruitments.table.cols.status'),
          value: 'status'
        },
        {
          text: this.$t('components.recruitments.table.cols.currentEvaluator'),
          value: 'evaluator_fullname',
          sortable: false
        },
        {
          text: this.$t('components.recruitments.table.cols.source'),
          value: 'source'
        },
        {
          text: this.$t('components.recruitments.table.cols.receivedAt'),
          value: 'received_at'
        },
        {
          text: this.$t('components.recruitments.table.cols.acceptCurrentProcessing'),
          value: 'accept_current_processing',
        },
        {
          text: this.$t('components.recruitments.table.cols.acceptFutureProcessing'),
          value: 'accept_future_processing',
        }
      ]
    }
  },
  methods: {
    fetchRecruitDocuments(query) {
      this.$store.dispatch('RecruitDocumentsModule/fetchRecruitDocuments', query)
    }
  }
}
</script>
