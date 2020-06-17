<template>
  <v-list>
    <v-list-item :to="{ name: 'general_settings_path' }" color="primary" exact>
      <v-list-item-action>
        <v-icon>mdi-earth</v-icon>
      </v-list-item-action>

      <v-list-item-content>
        <v-list-item-title>
          {{ $t('components.settings.sidebarNav.general') }}
        </v-list-item-title>
      </v-list-item-content>
    </v-list-item>

    <v-list-item :to="{ name: 'notifications_settings_path' }" color="primary" exact>
      <v-list-item-action>
        <v-icon>mdi-alarm-light-outline</v-icon>
      </v-list-item-action>

      <v-list-item-content>
        <v-list-item-title>
          {{ $t('components.settings.sidebarNav.notifications') }}
        </v-list-item-title>
      </v-list-item-content>
    </v-list-item>

    <v-divider class="my-2" />

    <v-list-item :to="{ name: 'profile_settings_path' }" color="primary" exact>
      <v-list-item-action>
        <v-icon>mdi-account-edit</v-icon>
      </v-list-item-action>

      <v-list-item-content>
        <v-list-item-title>
          {{ $t('components.settings.sidebarNav.profile') }}
        </v-list-item-title>
      </v-list-item-content>
    </v-list-item>

    <v-list-item :to="{ name: 'support_settings_path' }" color="primary" exact>
      <v-list-item-action>
        <v-icon>mdi-help-rhombus-outline</v-icon>
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
