<template>
  <div class="box box--with-content">
    <v-text-field label="Template name" value="Rubies"></v-text-field>
    <v-layout row wrap>
      <v-flex xs6>
        <div class="employee-header">
          <h3 class="employee-header__fullname">&lsaquo; employee name &rsaquo;</h3>
          <h4 class="employee-header__position">&lsaquo; employee position &rsaquo;</h4>
        </div>

      </v-flex>

      <v-flex xs6>
        <v-layout row>
          <v-flex xs4>
            <div class="date-box">
              <h5 class="date-box__date">&lsaquo; date &rsaquo;</h5>
              <h6 class="date-box__description">on board since</h6>
            </div>
          </v-flex>
          <v-flex xs4>
            <div class="date-box">
              <h5 class="date-box__date">&lsaquo; date &rsaquo;</h5>
              <h6 class="date-box__description">previous evaluation</h6>
            </div>
          </v-flex>
          <v-flex xs4>
            <div class="date-box">
              <h5 class="date-box__date">&lsaquo; date &rsaquo;</h5>
              <h6 class="date-box__description">next evaluation</h6>
            </div>
          </v-flex>

        </v-layout>
      </v-flex>

      <v-flex xs6>
        <div class="form-box">
          <h5 class="form-box__heading">
            <span class="form-box__heading-content">
              <v-text-field label="Section title" outline></v-text-field>
            </span>
          </h5>

          <v-text-field class="form-box__create-field" label="New rating option" box></v-text-field>

          <div class="form-box__items form-box__items--scrollable">
            <v-list>
              <v-list-tile v-for="item in ratingItems" :key="item.id">
                <v-list-tile-action class="pt-3">
                  <v-checkbox v-model="item.checked"></v-checkbox>
                </v-list-tile-action>
                <v-list-tile-content @click.prevent="item.checked = !item.checked">
                  <v-list-tile-title>{{ item.name }}</v-list-tile-title>
                </v-list-tile-content>
              </v-list-tile>
            </v-list>
          </div>
          
        </div>
      </v-flex>

      <v-flex xs6>
        <div class="form-box">
          <h5 class="form-box__heading">
            <span class="form-box__heading-content">
              <v-text-field label="Section title" outline></v-text-field>
            </span>
          </h5>

          <v-text-field class="form-box__create-field" label="New bool option" box></v-text-field>
          <div class="form-box__items form-box__items--scrollable">
            <v-list>
              <v-list-tile v-for="item in boolItems" :key="item.id" @click="">
                <v-list-tile-action class="pt-3">
                  <v-checkbox v-model="item.checked"></v-checkbox>
                </v-list-tile-action>
                <v-list-tile-content @click.prevent="item.checked = !item.checked">
                  <v-list-tile-title>{{ item.name }}</v-list-tile-title>
                </v-list-tile-content>
              </v-list-tile>
            </v-list>
          </div>
        </div>
      </v-flex>

      <v-flex xs12>
        <div class="form-box">
          <h5 class="form-box__heading">
            <span class="form-box__heading-content">
              <v-text-field label="Section title" outline></v-text-field>
            </span>
          </h5>

          <div class="form-box__text">
            <p>{{ additionalInfo }}</p>
          </div>
        </div>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
export default {
  name: 'EmployeeCard',
  data () {
    return {
      ratingItems: [
        { id: 0, name: 'Consequuntur', checked: false },
        { id: 1, name: 'Voluptatem', checked: false },
        { id: 2, name: 'Accusantium', checked: false },
        { id: 3, name: 'Aperiam', checked: false },
        { id: 4, name: 'Incidunt', checked: false },
        { id: 5, name: 'Reprehenderit', checked: false },
        { id: 6, name: 'Dolorem', checked: false },
        { id: 7, name: 'Omnis', checked: false },
        { id: 8, name: 'Ipsum', checked: false }
      ],
      boolItems: [
        { id: 0, name: 'Lorem ipsum dolor', checked: false },
        { id: 1, name: 'Consectetur adipiscing elit', checked: false },
        { id: 2, name: 'Eiusmod tempor', checked: false },
        { id: 3, name: 'Dolore magna', checked: false },
        { id: 4, name: 'Minim veniam', checked: false },
        { id: 5, name: 'Ullamco laboris', checked: false },
        { id: 6, name: 'Commodo consequat', checked: false },
        { id: 7, name: 'Excepteur sint occaecat cupidatat non proident', checked: false },
        { id: 8, name: 'In culpa qui officia', checked: false },
        { id: 9, name: 'Mollit anim id est laborum', checked: false }
      ],
      additionalInfo: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'
    }
  }
}
</script>
