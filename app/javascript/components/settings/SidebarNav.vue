<template>
  <v-list>
    <v-list-tile :to="{ name: 'general_settings_path' }" exact>
      <v-list-tile-action>
        <v-icon>language</v-icon>
      </v-list-tile-action>

      <v-list-tile-content>
        <v-list-tile-title>
          {{ $t('components.settings.sidebarNav.general') }}
        </v-list-tile-title>
      </v-list-tile-content>
    </v-list-tile>

    <v-divider class="my-2" />

    <v-list-tile :to="{ name: 'profile_settings_path' }" exact>
      <v-list-tile-action>
        <v-icon>person</v-icon>
      </v-list-tile-action>

      <v-list-tile-content>
        <v-list-tile-title>
          {{ $t('components.settings.sidebarNav.profile') }}
        </v-list-tile-title>
      </v-list-tile-content>
    </v-list-tile>

    <v-list-tile :to="{ name: 'support_settings_path' }" exact>
      <v-list-tile-action>
        <v-icon>help_outline</v-icon>
      </v-list-tile-action>

      <v-list-tile-content>
        <v-list-tile-title>
          {{ $t('components.settings.sidebarNav.support') }}
        </v-list-tile-title>
      </v-list-tile-content>
    </v-list-tile>
  </v-list>
</template>

<script>
export default {
  name: 'SidebarNav'
}
</script>
