<template>
  <section class="panel">
    <v-layout row>
      <v-flex xs6>
        <h2 class="panel__heading">{{ $t('settings.title') }}</h2>
      </v-flex>

      <v-flex>
        <div class="panel__action-bar">
        </div>
      </v-flex>
    </v-layout>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout wrap row>

          <v-flex xs10 offset-xs1 lg3 offset-lg0>
            <v-list>
              <template v-for="panel in panels">
                <v-divider v-if="panel.dividerBefore" :key="`divider_${panel.id}`" class="my-2"></v-divider>
                <v-list-tile :key="panel.id" :to="{ name: panel.path }" exact>
                  <v-list-tile-action>
                    <v-icon>{{ panel.icon }}</v-icon>
                  </v-list-tile-action>
                  <v-list-tile-content>
                    <v-list-tile-title>{{ $t(`settings.sidebar.${panel.name}`) }}</v-list-tile-title>
                  </v-list-tile-content>
                </v-list-tile>
              </template>
            </v-list>
          </v-flex>

          <v-flex xs12 lg9>
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
        { id: 0, name: 'general', icon: 'language', path: 'general_settings_path' },
        { id: 10, name: 'evaluations', icon: 'assignment_turned_in', path: 'evaluations_settings_path' },
        { id: 20, name: 'profile', icon: 'person', path: 'profile_settings_path', dividerBefore: true },
        { id: 30, name: 'support', icon: 'help_outline', path: 'support_path' }
      ]
    }
  }
}
</script>