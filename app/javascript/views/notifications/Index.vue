<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">
        <h2>{{ $t('views.notifications.index.title') }}</h2>
      </div>

      <div class="panel__actions" />
    </div>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout row wrap>
          <v-flex xs12 lg6 >
            <paginated-list />
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import PaginatedList from '@components/notifications/PaginatedList'

export default {
  name: 'NotificationsIndex',
  components: { PaginatedList }
}
</script>
