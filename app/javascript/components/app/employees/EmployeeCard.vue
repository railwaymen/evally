<template>
  <div class="box box--with-content">
    <v-layout row wrap>
      <v-flex xs6>
        <div class="employee-header">
          <h3 class="employee-header__fullname">Rob Stark</h3>
          <h4 class="employee-header__position">Ruby on Rails Developer</h4>
        </div>

      </v-flex>

      <v-flex xs6>
        <v-layout row>
          <v-flex xs4>
            <div class="date-box">
              <h5 class="date-box__date">March 2018</h5>
              <h6 class="date-box__description">on board since</h6>
            </div>
          </v-flex>
          <v-flex xs4>
            <div class="date-box">
              <h5 class="date-box__date">June 2018</h5>
              <h6 class="date-box__description">previous evaluation</h6>
            </div>
          </v-flex>
          <v-flex xs4>
            <div class="date-box">
              <h5 class="date-box__date">December 2018</h5>
              <h6 class="date-box__description">next evaluation</h6>
            </div>
          </v-flex>

        </v-layout>
      </v-flex>

      <v-flex xs6>
        <div class="form-box">
          <h5 class="form-box__heading">
            <span class="form-box__heading-content">Primary section</span>
          </h5>

          <div class="form-box__items">
            <v-list>
              <v-list-tile v-for="item in ratingItems" :key="item.id" :class="{ 'need-to-improve': item.needToImprove }">
                <v-list-tile-content>
                  <v-list-tile-title v-text="item.name"></v-list-tile-title>
                </v-list-tile-content>

                <v-list-tile-action>
                  <v-rating :value="item.rating" readonly></v-rating>
                </v-list-tile-action>
              </v-list-tile>
            </v-list>
          </div>
          
        </div>
      </v-flex>

      <v-flex xs6>
        <div class="form-box">
          <h5 class="form-box__heading">
            <span class="form-box__heading-content">Secondary section</span>
          </h5>

          <div class="form-box__items">
            <v-list>
              <v-list-tile v-for="item in boolItems" :key="item.id" :class="{ 'need-to-improve': item.needToImprove }">
                <v-list-tile-content>
                  <v-list-tile-title v-text="item.name"></v-list-tile-title>
                </v-list-tile-content>

                <v-list-tile-action>
                  <span>{{ item.value }}</span>
                </v-list-tile-action>
              </v-list-tile>
            </v-list>
          </div>
        </div>
      </v-flex>

      <v-flex xs12>
        <div class="form-box">
          <h5 class="form-box__heading">
            <span class="form-box__heading-content">Additional information</span>
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
        { id: 0, name: 'Consequuntur', rating: 5, needToImprove: false },
        { id: 1, name: 'Voluptatem', rating: 5, needToImprove: false },
        { id: 2, name: 'Accusantium', rating: 4, needToImprove: true },
        { id: 3, name: 'Aperiam', rating: 2, needToImprove: false },
        { id: 4, name: 'Incidunt', rating: 3, needToImprove: true },
        { id: 5, name: 'Reprehenderit', rating: 1, needToImprove: false },
        { id: 6, name: 'Dolorem', rating: 1, needToImprove: false },
        { id: 7, name: 'Omnis', rating: 2, needToImprove: true },
        { id: 8, name: 'Ipsum', rating: 1, needToImprove: false }
      ],
      boolItems: [
        { id: 0, name: 'Lorem ipsum dolor', value: 'Yes', needToImprove: false },
        { id: 1, name: 'Consectetur adipiscing elit', value: 'No', needToImprove: false },
        { id: 2, name: 'Eiusmod tempor', value: 'Yes', needToImprove: false },
        { id: 3, name: 'Dolore magna', value: 'Yes', needToImprove: false },
        { id: 4, name: 'Minim veniam', value: 'No', needToImprove: true },
        { id: 5, name: 'Ullamco laboris', value: 'No', needToImprove: true },
        { id: 6, name: 'Commodo consequat', value: 'No', needToImprove: false },
        { id: 7, name: 'Excepteur sint occaecat cupidatat non proident', value: 'Yes', needToImprove: false },
        { id: 8, name: 'In culpa qui officia', value: 'No', needToImprove: true },
        { id: 9, name: 'Mollit anim id est laborum', value: 'No', needToImprove: false }
      ],
      additionalInfo: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'
    }
  }
}
</script>
