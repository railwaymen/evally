<template>
  <section class="app">
    <v-app-bar
      class="elevation-1 toolbar"
      color="white"
      fixed
      scroll-off-screen
    >
      <v-toolbar-title>
        <router-link class="logo" :to="{ name: 'dashboard_path' }">
          <img src="@assets/images/logo_black.png" class="logo__img" alt="Logo Evally">
        </router-link>
      </v-toolbar-title>

      <v-spacer />

      <v-menu transition="slide-y-transition" offset-y>
        <template #activator="{ on }">
          <span class="profile" v-on="on" v-ripple>
            <v-avatar class="profile__avatar" color="primary" size="32">
              <span class="white--text body-2" data-cy="profile-initials">
                {{ user.initials }}
              </span>
            </v-avatar>

            <span class="profile__fullname" data-cy="profile-fullname">
              {{ user.fullname }}
            </span>

            <span class="profile__arrow">
              <v-icon size="24">mdi-chevron-down</v-icon>
            </span>
          </span>
        </template>

        <v-list>
          <template v-if="$vuetify.breakpoint.mdAndDown">
            <v-list-item :to="{ name: 'dashboard_path' }">
              <v-list-item-action>
                <v-icon>mdi-view-dashboard</v-icon>
              </v-list-item-action>

              <v-list-item-title>{{ $t('shared.navbar.dashboard') }}</v-list-item-title>
            </v-list-item>

            <v-list-item :to="{ name: 'drafts_path' }">
              <v-list-item-action>
                <v-icon>mdi-file-edit-outline</v-icon>
              </v-list-item-action>

              <v-list-item-title>{{ $t('shared.navbar.drafts') }}</v-list-item-title>
            </v-list-item>

            <v-list-item :to="{ name: 'employees_path' }">
              <v-list-item-action>
                <v-icon>mdi-account-group-outline</v-icon>
              </v-list-item-action>

              <v-list-item-title>{{ $t('shared.navbar.employees') }}</v-list-item-title>
            </v-list-item>

            <v-list-item :to="{ name: 'templates_path' }">
              <v-list-item-action>
                <v-icon>mdi-file-multiple-outline</v-icon>
              </v-list-item-action>

              <v-list-item-title>{{ $t('shared.navbar.templates') }}</v-list-item-title>
            </v-list-item>

            <v-list-item v-if="user.isAdmin" :to="{ name: 'users_path' }">
              <v-list-item-action>
                <v-icon>mdi-account-multiple-plus-outline</v-icon>
              </v-list-item-action>

              <v-list-item-title>{{ $t('shared.navbar.users') }}</v-list-item-title>
            </v-list-item>

            <v-divider class="my-2" />
          </template>

          <v-list-item :to="{ name: 'general_settings_path' }">
            <v-list-item-action>
              <v-icon>mdi-settings</v-icon>
            </v-list-item-action>

            <v-list-item-title>{{ $t('shared.navbar.settings') }}</v-list-item-title>
          </v-list-item>

          <v-list-item @click="logout" data-cy="li-logout">
            <v-list-item-action>
              <v-icon>mdi-logout-variant</v-icon>
            </v-list-item-action>

            <v-list-item-title>{{ $t('shared.navbar.logout') }}</v-list-item-title>
          </v-list-item>

        </v-list>
      </v-menu>

      <template #extension v-if="$vuetify.breakpoint.lgAndUp">
        <v-tabs
          :hide-slider="canHideSlider"
          slider-color="primary"
          grow
        >
          <v-tab :to="{ name: 'dashboard_path' }">
            <v-icon>mdi-view-dashboard</v-icon>
            <span class="separator" />

            {{ $t('shared.navbar.dashboard') }}
          </v-tab>

          <v-tab :to="{ name: 'drafts_path' }">
            <v-icon>mdi-file-edit-outline</v-icon>
            <span class="separator" />

            {{ $t('shared.navbar.drafts') }}
          </v-tab>

          <v-tab :to="{ name: 'employees_path' }">
            <v-icon>mdi-account-group-outline</v-icon>
            <span class="separator" />

            {{ $t('shared.navbar.employees') }}
          </v-tab>

          <v-tab :to="{ name: 'templates_path' }">
            <v-icon>mdi-file-multiple-outline</v-icon>
            <span class="separator" />

            {{ $t('shared.navbar.templates') }}
          </v-tab>

          <v-tab v-if="user.isAdmin" :to="{ name: 'users_path' }">
            <v-icon>mdi-account-multiple-plus-outline</v-icon>
            <span class="separator" />

            {{ $t('shared.navbar.users') }}
          </v-tab>
        </v-tabs>
      </template>
    </v-app-bar>

    <router-view />

    <forms-dialog />
    <confirm-dialog />
  </section>
</template>

<script>
import { mapGetters } from 'vuex'

import FormsDialog from '@components/shared/FormsDialog'
import ConfirmDialog from '@components/shared/ConfirmDialog'

export default {
  name: 'Base',
  components: { ConfirmDialog, FormsDialog },
  computed: {
    ...mapGetters({
      user: 'AuthenticationModule/user',
      setting: 'AuthenticationModule/setting',
    }),

    canHideSlider() {
      return this.$route.path.startsWith('/app/settings')
    }
  },
  methods: {
    logout () {
      this.$store.dispatch('AuthenticationModule/destroy')
        .then(() => this.$router.push({ name: 'login_path' }))
    }
  },
  created() {
    this.$store.dispatch('AuthenticationModule/show')
      .then(data => this.updateLocale(data.setting.lang))
  }
}
</script>
