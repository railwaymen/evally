<template>
  <section class="app">
    <v-toolbar
      :tabs="$vuetify.breakpoint.lgAndUp"
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
        <span class="profile" slot="activator" data-cy="profile-btn" v-ripple>
          <v-avatar class="profile__avatar" color="primary" size="32">
            <span class="white--text body-1" data-cy="profile-initials">{{ user.initials() }}</span>
          </v-avatar>
          <span class="profile__fullname" data-cy="profile-fullname">{{ user.fullname() }}</span>
          <v-icon class="profile__arrow" size="24">
            expand_more
          </v-icon>
        </span>

        <v-list>
          <template v-if="$vuetify.breakpoint.mdAndDown">
            <v-list-tile v-for="tab in tabs" :key="`tab-${tab.id}`" :to="{ name: tab.path }">
              <v-list-tile-action>
                <v-icon>{{ tab.icon }}</v-icon>
              </v-list-tile-action>
              <v-list-tile-title>{{ $t(`navbar.${tab.name}`) }}</v-list-tile-title>
            </v-list-tile>

            <v-divider class="my-2" />
          </template>

          <v-list-tile v-for="item in items" :key="`item_${item.id}`"  :data-cy="`li-${item.name}`" :to="{ name: item.path }">
            <v-list-tile-action>
              <v-icon>{{ item.icon }}</v-icon>
            </v-list-tile-action>
            <v-list-tile-title>{{ $t(`navbar.${item.name}`) }}</v-list-tile-title>
          </v-list-tile>

          <!-- Log out list item -->
          <v-list-tile @click="logout" data-cy="li-logout">
            <v-list-tile-action>
              <v-icon>last_page</v-icon>
            </v-list-tile-action>
            <v-list-tile-title>{{ $t('navbar.logout') }}</v-list-tile-title>
          </v-list-tile>
        </v-list>
      </v-menu>

      <v-tabs
        v-if="$vuetify.breakpoint.lgAndUp"
        :hide-slider="canHideSlider"
        slot="extension"
        color="white"
        slider-color="primary"
        grow
      >
        <v-tab v-for="tab in tabs" :key="`tab_${tab.id}`" :data-cy="`tab-${tab.name}`" :to="{ name: tab.path }">
          <v-icon>{{ tab.icon }}</v-icon>
          <span class="separator" />
          {{ $t(`navbar.${tab.name}`) }}
        </v-tab>
      </v-tabs>
    </v-toolbar>

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
  data () {
    return {
      tabs: [
        { id: 0, name: 'dashboard', icon: 'dashboard', path: 'dashboard_path' },
        { id: 10, name: 'evaluations', icon: 'assignment_turned_in', path: 'drafts_path' },
        { id: 20, name: 'employees', icon: 'people', path: 'employees_path' },
        { id: 30, name: 'templates', icon: 'list_alt', path: 'templates_path' }
      ],
      items: [
        { id: 0, name: 'settings', icon: 'settings', path: 'general_settings_path' }
      ]
    }
  },
  computed: {
    ...mapGetters({
      user: 'AuthStore/user'
    }),

    canHideSlider() {
      return this.$route.path.startsWith('/app/settings')
    }
  },
  methods: {
    logout () {
      this.$store.dispatch('AuthStore/logOut').then(() => {
        this.flash({ success: 'You have been logged out succesfully.' })
        this.$router.push({ name: 'login_path' })
      })
    }
  },
  created() {
    this.$store.dispatch('AuthStore/getUser')
      .then(session => {
        this.updateLocale(session.setting.lang)
      })
      .catch(error => {
        this.flash({ error: 'User cannot be loaded due to some error: ' + this.renderError(error.response) })
      })
  }
}
</script>
