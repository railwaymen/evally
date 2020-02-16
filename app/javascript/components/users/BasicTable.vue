<template>
  <div class="box">
    <v-layout row wrap>
      <v-flex xs12 lg6>
        <v-text-field
          v-model="search"
          append-icon="mdi-magnify"
          label="Search ..."
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
            <v-tooltip right>
              <template #activator="{ on }">
                <v-btn
                  @click="$emit('edit', item.id)"
                  v-on="on"
                  icon
                >
                  <v-icon size="15">mdi-pencil</v-icon>
                </v-btn>
              </template>

              <span>{{ $t('shared.tooltips.edit') }}</span>
            </v-tooltip>
          </template>

          <template #item.fullname="{ item }">
            {{ item.fullname }}
          </template>

          <template #item.invitation_accepted_at="{ item }">
            {{ item.invitationAcceptedAt }}
          </template>

          <template #item.last_sign_in_at="{ item }">
            {{ item.lastSignInAt }}
          </template>
        </v-data-table>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
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
          text: 'Name',
          value: 'fullname'
        },
        {
          text: 'Email',
          value: 'email',
          align: 'center'
        },
        {
          text: 'Role',
          value: 'role',
          align: 'center'
        },
        {
          text: 'Date of Joining',
          value: 'invitation_accepted_at',
          align: 'center'
        },
        {
          text: 'Last Activity',
          value: 'last_sign_in_at',
          align: 'center'
        },
        {
          text: 'Status',
          value: 'status',
          align: 'center'
        },
      ]
    }
  }
}
</script>
