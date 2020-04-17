<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">
        <h2>Users</h2>
      </div>

      <div class="panel__actions">
        <v-tooltip bottom>
          <template #activator="{ on }">
            <v-btn
              @click="openCreateForm"
              v-on="on"
              color="green"
              icon
            >
              <v-icon>mdi-plus</v-icon>
            </v-btn>
          </template>

          <span>{{ $t('shared.tooltips.addNew') }}</span>
        </v-tooltip>
      </div>
    </div>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <basic-table
          :users="users"
          :loading="false"
          @edit="openUpdateForm"
        />
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapGetters } from 'vuex'
import { DialogsBus } from '@utils/dialogs_bus'

import { User } from '@models/user'

import BasicTable from '@components/users/BasicTable'
import UserForm from '@components/users/UserForm'

export default {
  name: 'Users',
  components: { BasicTable },
  methods: {
    openCreateForm() {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: UserForm,
        maxWidth: 500,
        props: {
          user: new User()
        }
      })
    },
    openUpdateForm(id) {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: UserForm,
        maxWidth: 500,
        props: {
          user: this.users.findById(id)
        }
      })
    }
  },
  computed: {
    ...mapGetters({
      users: 'UsersModule/users',
      loading: 'UsersModule/loading'
    })
  },
  created() {
    this.$store.dispatch('UsersModule/fetchUsers')
  }
}
</script>
