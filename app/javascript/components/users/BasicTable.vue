<template>
  <div class="box">
    <server-side-table
      :composerClass="composerClass"
      :headers="headers"
      :items="users.models"
      :footer-props="{ 'items-per-page-options': [50, 100, 200] }"
      :server-items-length="totalCount"
      :loading="loading"
      @change:options="fetchUsers"
    >
      <template #search="{ options, searchBy }">
        <v-flex xs12 lg4>
          <v-text-field
            :value="options.search"
            @input="searchBy"
            append-icon="mdi-magnify"
            :label="$t('components.users.table.search')"
            solo
          />
        </v-flex>
      </template>

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

      <template #item.last_name="{ item }">
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
    </server-side-table>
  </div>
</template>

<script>
import { mapState } from 'vuex'

import { UsersList } from '@models/user'

import ServerSideTable from '@components/shared/ServerSideTable'

import UsersTableComposer from '@utils/data_tables/users_table_composer'

export default {
  name: 'BasicTable',
  components: { ServerSideTable },
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
    },
    totalCount: {
      type: Number,
      required: true,
      default: 0
    }
  },
  data() {
    return {
      composerClass: UsersTableComposer,
      headers: [
        {
          sortable: false,
          value: 'action',
        },
        {
          text: this.$t('components.users.table.cols.name'),
          value: 'last_name'
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
  methods: {
    fetchUsers(query) {
      this.$store.dispatch('UsersModule/fetchUsers', query)
    }
  },
  computed: {
    ...mapState('AuthenticationModule', [
      'user'
    ])
  }
}
</script>
