<template>
  <v-list>
    <v-list-item :to="{ name: 'general_settings_path' }" exact>
      <v-list-item-action>
        <v-icon>language</v-icon>
      </v-list-item-action>

      <v-list-item-content>
        <v-list-item-title>
          {{ $t('components.settings.sidebarNav.general') }}
        </v-list-item-title>
      </v-list-item-content>
    </v-list-item>

    <v-divider class="my-2" />

    <v-list-item :to="{ name: 'profile_settings_path' }" exact>
      <v-list-item-action>
        <v-icon>person</v-icon>
      </v-list-item-action>

      <v-list-item-content>
        <v-list-item-title>
          {{ $t('components.settings.sidebarNav.profile') }}
        </v-list-item-title>
      </v-list-item-content>
    </v-list-item>

    <v-list-item :to="{ name: 'support_settings_path' }" exact>
      <v-list-item-action>
        <v-icon>help_outline</v-icon>
      </v-list-item-action>

      <v-list-item-content>
        <v-list-item-title>
          {{ $t('components.settings.sidebarNav.support') }}
        </v-list-item-title>
      </v-list-item-content>
    </v-list-item>
  </v-list>
</template>

<script>
export default {
  name: 'SidebarNav'
}
</script>
