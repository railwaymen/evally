<template>
  <div class="box">
    <v-layout row wrap>
      <v-flex xs12 lg6>
        <v-text-field
          v-model="search"
          append-icon="mdi-magnify"
          :label="$t('components.users.table.search')"
          filled
        />
      </v-flex>

      <v-flex xs12>
        <v-data-table
          :headers="headers"
          :items="users.models"
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
            {{ item.fullname }}

            <span v-if="item.id === user.id">
              ({{ $t('components.users.table.you') }})
            </span>
          </template>

          <template #item.role="{ item }">
            {{ $t(`models.user.roles.${item.role}`) }}
          </template>

          <template #item.last_sign_in_at="{ item }">
            {{ item.lastSignInAt }}
          </template>

          <template #item.status="{ item }">
            {{ $t(`models.user.statuses.${item.status}`) }}
          </template>

          <template #item.invitation_status="{ item }">
            {{ item.invitation_status ? $t(`models.user.invitationStatuses.${item.invitation_status}`) : '---' }}
          </template>
        </v-data-table>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

import { UsersList } from '@models/user'

export default {
  name: 'BasicTable',
  props: {
    loading: {
      type: Boolean,
      required: true,
      default: false
    },
    users: {
      type: UsersList,
      required: true,
      default: () => new UsersList()
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
          text: this.$t('components.users.table.cols.name'),
          value: 'fullname'
        },
        {
          text: this.$t('components.users.table.cols.email'),
          value: 'email',
          align: 'center'
        },
        {
          text: this.$t('components.users.table.cols.role'),
          value: 'role',
          align: 'center'
        },
        {
          text: this.$t('components.users.table.cols.latestActivity'),
          value: 'last_sign_in_at',
          align: 'center'
        },
        {
          text: this.$t('components.users.table.cols.status'),
          value: 'status',
          align: 'center'
        },
        {
          text: this.$t('components.users.table.cols.invitationStatus'),
          value: 'invitation_status',
          align: 'center'
        }
      ]
    }
  },
  computed: {
    ...mapGetters({
      user: 'SessionModule/user'
    })
  }
}
</script>
