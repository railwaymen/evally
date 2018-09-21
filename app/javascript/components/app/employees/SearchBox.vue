<template>
  <div class="search-box">
    <div class="search-box__input">
      <v-text-field
        v-model="search"
        append-icon="search"
        label="Search by name"
        box
      ></v-text-field>
    </div>

    <div class="search-box__list">
      <v-list two-line subheader>
        <v-subheader>Recently evaluated</v-subheader>

        <v-list-tile v-for="employee in recentlyEvaluated" :key="employee.id" @click="selectEmployee">
          <!-- <v-list-tile-action>
            <v-icon>star</v-icon>
          </v-list-tile-action> -->
          <v-list-tile-content>
            <v-list-tile-title>{{ employee.first_name }} {{ employee.last_name }}</v-list-tile-title>
            <v-list-tile-sub-title>{{ employee.position }}</v-list-tile-sub-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>

      <v-list two-line subheader>
        <v-subheader>All employees</v-subheader>

        <v-list-tile v-for="employee in allEmployees" :key="employee.id" @click="selectEmployee">
          <!-- <v-list-tile-action>
            <v-icon>star</v-icon>
          </v-list-tile-action> -->
          <v-list-tile-content>
            <v-list-tile-title>{{ employee.first_name }} {{ employee.last_name }}</v-list-tile-title>
            <v-list-tile-sub-title>{{ employee.position }}</v-list-tile-sub-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
    </div>
  </div>
</template>

<script>
export default {
  name: 'SearchBox',
  data () {
    return {
      search: '',
      recentlyEvaluated: [
        { id: 0, first_name: 'Rob', last_name: 'Stark', position: 'Ruby on Rails Developer' }
      ],
      allEmployees: [
        { id: 0, first_name: 'Rob', last_name: 'Stark', position: 'Ruby on Rails Developer' },
        { id: 1, first_name: 'John', last_name: 'Doe', position: 'Frontend Developer' },
        { id: 2, first_name: 'Paul', last_name: 'Evans', position: 'Android Developer' },
        { id: 3, first_name: 'Frank', last_name: 'Doe', position: 'Graphic Designer' },
        { id: 4, first_name: 'James', last_name: 'Smith', position: 'iOS Developer' }
      ]
    }
  },
  methods: {
    selectEmployee() {
      console.log('Hahaha!')
    }
  }
}
</script>
