<template>
  <section class="panel">
    <v-layout row>
      <v-flex xs6>
        <h2 class="panel__heading">Settings</h2>
      </v-flex>

      <v-flex>
        <div class="panel__action-bar">
        </div>
      </v-flex>
    </v-layout>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout row>

          <v-flex xs3>
            <v-list>
              <v-list-tile v-for="panel in panels" :key="panel.id" :to="{ name: panel.path }" exact>
                <v-list-tile-action>
                  <v-icon>{{ panel.icon }}</v-icon>
                </v-list-tile-action>
                <v-list-tile-content>
                  <v-list-tile-title>{{ panel.name }}</v-list-tile-title>
                </v-list-tile-content>
              </v-list-tile>
            </v-list>
          </v-flex>

          <v-flex xs9>
            <router-view></router-view>
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
export default {
  name: 'Settings',
  data() {
    return {
      panels: [
        { id: 0, name: 'General', icon: 'language', path: 'general_settings_path' },
        { id: 10, name: 'Evaluations', icon: 'assignment_turned_in', path: 'evaluations_settings_path' }
      ]
    }
  }
}
</script>