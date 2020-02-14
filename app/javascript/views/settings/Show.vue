<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">
        <h2>{{ $t('views.settings.show.title') }}</h2>
      </div>
    </div>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout wrap row>
          <v-flex xs10 offset-xs1 lg3 offset-lg0>
            <sidebar-nav />
          </v-flex>

          <v-flex xs12 lg9>
            <router-view />
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import SidebarNav from '@components/settings/SidebarNav'

export default {
  name: 'Settings',
  components: { SidebarNav }
}
</script>
