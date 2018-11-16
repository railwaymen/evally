</<template>
  <div class="search-box mt-4">

    <div class="search-box__input">
      <v-text-field
        append-icon="search"
        label="Search by name"
        box
      ></v-text-field>
    </div>

    <v-expansion-panel class="elevation-0">
      <v-expansion-panel-content
        v-for="(item,i) in 5"
        :key="i"
      >
        <div slot="header">
          <div class="vcard-header">
            <v-icon>person_outline</v-icon>
            <span class="separator"></span>
            John Doe (30)
          </div>
        </div>

        <v-card>
          <v-card-text>
            <div class="vcard pa-2">
              <div class="vcard__info">
                <h3 class="vcard__title">Position</h3>
                <div class="vcard__position">Junior Web Developer</div>
              </div>

              <div class="vcard__info">
                <h3 class="vcard__title">Cooperation</h3>
                <v-layout row>
                  <v-flex xs6>
                    <div class="vcard__date">January 1st, 2016</div>
                    <div class="vcard__date-text">since</div>
                  </v-flex>

                  <v-flex xs6>
                    <div class="vcard__date">December 31st, 2018</div>
                    <div class="vcard__date-text">until</div>
                  </v-flex>
                </v-layout>
              </div>

              <div class="vcard__evaluations">
                <v-list two-line subheader>
                  <v-subheader>List of evaluations (15)</v-subheader>

                  <v-list-tile v-for="(item,i) in 5" :key="i">
                    <v-list-tile-content>
                      <v-list-tile-title>Junior Web Dev</v-list-tile-title>
                      <v-list-tile-sub-title>July 2018</v-list-tile-sub-title>
                    </v-list-tile-content>
                  </v-list-tile>
                </v-list>
              </div>
            </div>
          </v-card-text>
        </v-card>
      </v-expansion-panel-content>
    </v-expansion-panel>
  </div>
</template>

<script>
export default {
  name: 'EmployeesListBox',
  data() {
    return {

    }
  }
}
</script>
