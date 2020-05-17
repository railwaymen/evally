<template>
  <v-data-table
    :headers="headers"
    :items="recruits.models"
    :loading="loading"
  >
    <template #item.fullname="{ item }">
      <router-link :to="item.recruitDocumentPath">
        {{ item.fullname }}
      </router-link>
    </template>

    <template #item.skill_value="{ item }">
      <v-rating
        v-if="item.skill.group === 'rating'"
        :value="item.skill.value"
        background-color="grey"
        length="3"
        readonly
      />

      <v-chip
        v-if="item.skill.group === 'bool'"
        :color="item.skill.value ? 'primary' : ''"
        label
      >
        {{ item.skill.value ? $t('components.recruitments.searchTable.labels.yes') : $t('components.recruitments.searchTable.labels.no') }}
      </v-chip>
    </template>

    <template #item.received_at="{ item }">
      {{ item.receivedAt }}
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

    <template #item.evaluation_date="{ item }">
      {{ item.evaluationDate }}
    </template>

    <template #item.evaluator_fullname="{ item }">
      {{ item.evaluator_fullname || '---' }}
    </template>

    <template #item.accept_current_processing="{ item }">
      <v-icon>{{ item.accept_current_processing ? 'mdi-check' : 'mdi-minus' }}</v-icon>
    </template>

    <template #item.accept_future_processing="{ item }">
      <v-icon>{{ item.accept_future_processing ? 'mdi-check' : 'mdi-minus' }}</v-icon>
    </template>
  </v-data-table>
</template>

<script>
import { RecruitsList } from '@models/recruit'

export default {
  name: 'SearchTable',
  props: {
    recruits: {
      type: RecruitsList,
      required: true,
      default: () => new RecruitsList()
    },
    loading: {
      type: Boolean,
      requied: true,
      default: false
    }
  },
  data() {
    return {
      headers: [
        {
          text: this.$t('components.recruitments.searchTable.cols.name'),
          value: 'fullname'
        },
        {
          text: this.$t('components.recruitments.searchTable.cols.skill'),
          value: 'skill_value'
        },
        {
          text: this.$t('components.recruitments.searchTable.cols.group'),
          value: 'group',
        },
        {
          text: this.$t('components.recruitments.searchTable.cols.position'),
          value: 'position',
        },
        {
          text: this.$t('components.recruitments.searchTable.cols.source'),
          value: 'source',
        },
        {
          text: this.$t('components.recruitments.searchTable.cols.receivedDate'),
          value: 'received_at',
        },
        {
          text: this.$t('components.recruitments.searchTable.cols.status'),
          value: 'status',
        },
        {
          text: this.$t('components.recruitments.searchTable.cols.evaluationDate'),
          value: 'evaluation_date',
        },
        {
          text: this.$t('components.recruitments.searchTable.cols.evaluatorName'),
          value: 'evaluator_fullname',
        },
        {
          text: this.$t('components.recruitments.searchTable.cols.acceptCurrentProcessing'),
          value: 'accept_current_processing',
        },
        {
          text: this.$t('components.recruitments.searchTable.cols.acceptFutureProcessing'),
          value: 'accept_future_processing',
        }
      ]
    }
  }
}
</script>
