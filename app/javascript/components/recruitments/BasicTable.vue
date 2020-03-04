<template>
  <div class="box">
    <v-layout row wrap>
      <v-flex xs12 lg6>
        <v-text-field
          v-model="search"
          append-icon="mdi-magnify"
          :label="$t('components.recruitments.table.search')"
          filled
        />
      </v-flex>

      <v-combobox :items="groups" @change="fitrByGroup" />
      <v-combobox :items="statuses" @change="fitrByStatus" />

      <v-flex xs12>
        <v-data-table
          :headers="headers"
          :items="recruitDocuments.models"
          :search="search"
          :loading="loading"
        >
          <template #item.action="{ item }">
            <v-tooltip bottom>
              <template #activator="{ on }">
                <v-icon
                  @click="$emit('edit', item.id)"
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

          <template #item.fullname="{ item }">
            <router-link :to="{ name: 'recruitment_path', params: { id: item.id }}">
              {{ item.fullname }}
            </router-link>
          </template>

          <template #item.received_at="{ item }">
            {{ item.receivedAt }}
          </template>

        </v-data-table>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { RecruitDocumentsList } from '@models/recruit_document'

export default {
  name: 'BasicTable',
  props: {
    loading: {
      type: Boolean,
      required: true,
      default: false
    },
    recruitDocuments: {
      type: RecruitDocumentsList,
      required: true,
      default: () => new RecruitDocumentsList()
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
    }
  },
  methods:{
    fitrByGroup(group) {
      this.$store.dispatch('RecruitmentsModule/index', group, null)
    },
    fitrByStatus(status) {
      this.$store.dispatch('RecruitmentsModule/index', null, status)
    }
  },
  data() {
    return {
      search: '',
      headers: [
        {
          sortable: false,
          value: 'action',
        },
        {
          text: this.$t('components.employees.table.cols.name'),
          value: 'fullname'
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
          text: this.$t('components.recruitments.table.cols.receivedAt'),
          value: 'received_at'
        }
      ]
    }
  }
}
</script>
