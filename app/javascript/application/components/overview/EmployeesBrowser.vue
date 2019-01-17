<template>
  <div class="box box--border-primary">
		<h3 class="box__header">Browse</h3>

    <div class="box__body">
      <v-form class="browser-form">
        <v-layout row wrap>
          <v-flex xs5>
            <v-combobox
              v-model="select"
              :items="items"
              chips
              label="Skill"
            ></v-combobox>
          </v-flex>

          <v-flex xs5>
            <div class="browser-form__grade">
              <span class="browser-form__grade--prefix">with minimum</span>
              <v-rating class="d-inline-block" v-model="rating" length="3"></v-rating>
              <span class="browser-form__grade--suffix">stars</span>
            </div>
          </v-flex>

          <v-flex xs2>
            <div class="browser-form__action">
              <v-btn color="primary" block flat>Search</v-btn>
            </div>
          </v-flex>
        </v-layout>
      </v-form>

      <div class="py-4">
        <v-data-table
          :headers="headers"
          :items="desserts"
        >
          <template slot="items" slot-scope="props">
            <td>{{ props.item.name }}</td>
            <td class="text-xs-center">{{ props.item.position }}</td>
            <td class="text-xs-center">{{ props.item.experience }}</td>
            <td class="text-xs-center">
              <v-chip v-for="(project, index) in props.item.projects" :key="index" label>{{ project }}</v-chip>
            </td>
            <td class="text-xs-center">
              <v-rating length="3" :value="props.item.skill"></v-rating>
            </td>
            <td class="text-xs-center">
              <v-icon
                small
              >
                list_alt
              </v-icon>
            </td>
          </template>
        </v-data-table>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'EmployeesBrowser',
  data() {
    return {
      select: null,
      rating: null,
      items: ['Ruby', 'Android', 'English', 'Spanish'],
      headers: [
        {
          text: 'Employee name',
          align: 'left',
          sortable: false,
          value: 'name'
        },
        { text: 'Position', value: 'position', align: 'center' },
        { text: 'Experience', value: 'experience', align: 'center' },
        { text: 'Current projects', value: 'projects', align: 'center' },
        { text: 'Skill', value: 'skill', align: 'center' },
        { text: 'Actions', value: 'name' }
      ],
      desserts: [
        {
          value: false,
          name: 'Joe Hart',
          position: 'Ruby Developer',
          experience: '2 years 324 days',
          projects: ['Rocket', 'Dixi', 'BitCoiner'],
          skill: 3
        },
        {
          value: false,
          name: 'Rick Smith',
          position: 'Ruby Developer',
          experience: '2 years 34 days',
          projects: ['Rocket', 'Foggy'],
          skill: 2
        },
        {
          value: false,
          name: 'Frank Moore',
          position: 'Junior Ruby Developer',
          experience: '1 year',
          projects: ['Teddy'],
          skill: 1
        }
      ]
    }
  }  
}
</script>