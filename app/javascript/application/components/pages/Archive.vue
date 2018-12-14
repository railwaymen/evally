<template>
  <section class="panel">
    <v-layout row>
      <v-flex xs6>
        <h2 class="panel__heading">{{ $t('archive.title') }}</h2>
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
            <v-tabs grow>
              <v-tabs-slider color="primary"></v-tabs-slider>
              <v-tab v-for="view in views" :key="view.id" :to="{ name: view.path }">
                {{ $t(`archive.sidebar.tabs.${view.name}`) }}
              </v-tab>
            </v-tabs>

            <activities-filter-box v-if="isActivitiesView"></activities-filter-box>
            <employees-list-box v-if="isEmployeesView"></employees-list-box>
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
import ActivitiesFilterBox from '@/components/archive/ActivitiesFilterBox'
import EmployeesListBox from '@/components/archive/EmployeesListBox'

export default {
  name: 'Archive',
  components: { ActivitiesFilterBox, EmployeesListBox },
  data() {
    return {
      views: [
        { id: 0, name: 'employees', path: 'employees_archive_path' },
        { id: 10, name: 'activities', path: 'activities_archive_path' }
      ]
    }
  },
  computed: {
    isActivitiesView() {
      return this.$route.name == 'activities_archive_path'
    },

    isEmployeesView() {
      return this.$route.name == 'employees_archive_path'
    }
  }
}
</script>