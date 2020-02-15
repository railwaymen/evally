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
        />
      </v-container>
    </div>
  </section>
</template>

<script>
import { UsersList } from '@models/user'

import BasicTable from '@components/users/BasicTable'

export default {
  name: 'Users',
  components: { BasicTable },
  data() {
    return {
      users: new UsersList(),
      loading: false
    }
  }
}
</script>
