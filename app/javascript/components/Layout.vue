<template>
  <section class="dashboard" style="padding-top: 10rem;">
    <v-toolbar class="elevation-1" color="white" fixed tabs>

      <v-toolbar-title>
        <router-link class="toolbar-logo" :to="{ name: 'dashboard_path' }">
          <img src="../assets/img/logo2_black.png" class="toolbar-logo__img" alt="Logo Evally">
        </router-link>
      </v-toolbar-title>

      <v-spacer></v-spacer>

      <v-menu offset-y nudge-bottom="8">
        <v-btn slot="activator" round flat>
          <v-icon size="24">add</v-icon>
          <span class="separator"></span>
          Add new
        </v-btn>

        <v-list>
          <v-list-tile v-for="item in creators" :key="item.id" to="/">
            <v-list-tile-title>
              <v-icon>{{ item.icon }}</v-icon>
              <span class="separator"></span>
              {{ item.name }}
            </v-list-tile-title>
          </v-list-tile>
        </v-list>
      </v-menu>

      <v-btn icon @click="flashNotification">
        <v-icon>notifications</v-icon>
      </v-btn>

      <v-menu offset-y nudge-bottom="8">
        <span class="toolbar-profile" slot="activator" v-ripple>
          <v-avatar class="toolbar-profile__avatar" color="primary" size="32">
            <span class="white--text body-1">JD</span>
          </v-avatar>
          <span class="toolbar-profile__fullname">Trevor Hansen</span>
          <v-icon class="toolbar-profile__arrow" size="24">
            expand_more
          </v-icon>
        </span>

        <v-list>
          <v-list-tile v-for="item in items" :key="item.id">
            <v-list-tile-title>
              <v-icon>{{ item.icon }}</v-icon>
              <span class="separator"></span>
              {{ item.name }}
            </v-list-tile-title>
          </v-list-tile>

          <!-- Log out list item -->
          <v-list-tile @click="logout">
            <v-list-tile-title>
              <v-icon>last_page</v-icon>
              <span class="separator"></span>
              Logout
            </v-list-tile-title>
          </v-list-tile>
        </v-list>
      </v-menu>

      <v-tabs slot="extension" v-model="model" color="white" slider-color="primary" grow>
        <v-tab v-for="tab in tabs" :key="tab.id" :to="{ name: tab.path }" exact>
          <v-icon>{{ tab.icon }}</v-icon>
          <span class="separator"></span>
          {{ tab.name }}
        </v-tab>
      </v-tabs>
    </v-toolbar>

    <router-view></router-view>

  </section>
</template>

<script>
export default {
  name: 'Layout',
  data () {
    return {
      model: 0,
      tabs: [
        { id: 0, name: 'Start', icon: 'dashboard', path: 'dashboard_path'},
        { id: 1, name: 'Employees', icon: 'people', path: 'employees_path'},
        { id: 2, name: 'Templates', icon: 'list_alt', path: 'templates_path'},
        { id: 3, name: 'Skills', icon: 'pool', path: 'skills_path'},
        { id: 4, name: 'Archive', icon: 'archive', path: 'archive_path'},
        { id: 5, name: 'Settings', icon: 'settings', path: 'settings_path'}
      ],
      creators: [
        { id: 0, name: 'Employee', icon: 'person', path: 'dashboard_path' },
        { id: 1, name: 'Evaluation', icon: 'how_to_reg', path: 'dashboard_path' },
        { id: 2, name: 'Template', icon: 'list_alt', path: 'dashboard_path' }
      ],
      items: [
        { id: 0, name: 'Profile', icon: 'person', path: 'profile_path' }
      ]
    }
  },
  methods: {
    flashNotification () {
      this.flash({ info: Math.random() })
    },
    logout () {
      this.$store.dispatch('AuthStore/logOut').then(() => {
        this.flash({ success: 'You have been logged out succesfully' })
        this.$router.push({ name: 'landing_page_path' })
      })
    }
  }
}
</script>
