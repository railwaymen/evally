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
              (you)
            </span>
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
          text: 'Latest Activity',
          value: 'last_sign_in_at',
          align: 'center'
        },
        {
          text: 'Status',
          value: 'status',
          align: 'center'
        },
        {
          text: 'Invitation Status',
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
