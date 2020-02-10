<template>
  <v-layout row wrap>
    <v-flex xs10 offset-xs1 lg3 offset-lg0>
      <h1>Sidebar</h1>
    </v-flex>

    <v-flex xs12 lg9>
      <div v-if="$route.name === 'employee_browse_path'" class="box">
        <v-layout row>
          <v-flex xs12>
            <h4 class="box__header">
              {{ $t('views.employees.show.instruction') }}
            </h4>
          </v-flex>
        </v-layout>
      </div>

      <router-view v-else />
    </v-flex>
  </v-layout>
</template>

<script>
export default {
  name: 'BrowseEmployee'
}
</script>
