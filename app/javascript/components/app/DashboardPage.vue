<template>
  <section class="panel">
    <v-layout row>
      <v-flex xs6>
        <h2 class="panel__heading">Hello Trevor!</h2>
      </v-flex>

      <v-flex>
        <div class="panel__action-bar">
          <v-btn color="green" flat>
            <v-icon>add</v-icon> Create evaluation
          </v-btn>
        </div>
      </v-flex>
    </v-layout>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout row>
          <v-flex xs9>
            <v-layout row>

              <v-flex xs6>
                <draft-list></draft-list>
              </v-flex>

              <v-flex xs6>
                <upcoming-list></upcoming-list>
              </v-flex>

            </v-layout>
          </v-flex>

          <v-flex xs3>
            <activities></activities>
          </v-flex>

        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import Activities from './dashboard/Activities'
import DraftList from './dashboard/DraftList'
import UpcomingList from './dashboard/UpcomingList'

export default {
  name: 'EvaluationPage',
  components: { 
    Activities,
    DraftList,
    UpcomingList
  }
}
</script>