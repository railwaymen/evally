<template>
  <section class="panel">
    <v-layout row>
      <v-flex xs6>
        <h2 class="panel__heading">Hello {{ user.first_name}}!</h2>
      </v-flex>

      <v-flex>
        <div class="panel__action-bar">

        </div>
      </v-flex>
    </v-layout>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout row>
          <v-flex xs8>
            <v-layout row wrap>

              <v-flex xs12>
                <drafts-list></drafts-list>
              </v-flex>

              <v-flex xs12>
                <upcoming-list></upcoming-list>
              </v-flex>

            </v-layout>
          </v-flex>

          <v-flex xs4>
            <activities></activities>
          </v-flex>

        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapGetters } from 'vuex'

import Activities from '@/components/widgets/Activities'
import DraftsList from '@/components/widgets/DraftsList'
import UpcomingList from '@/components/widgets/UpcomingList'

export default {
  name: 'Dashboard',
  components: { 
    Activities,
    DraftsList,
    UpcomingList
  },
  computed: {
    ...mapGetters({
      user: 'AuthStore/user'
    })
  },
  created() {
		this.$store.dispatch('EmployeesStore/index', { state: 'hired' })
      .catch(error => {
        this.flash({ error: 'Employees cannot be loaded due to some error: ' + this.renderError(error.response) })
      })

    this.$store.dispatch('EvaluationsStore/index', { state: 'draft' })
      .catch(error => {
        this.flash({ error: 'Draft evaluations cannot be loaded due to some error: ' + this.renderError(error.response) })
      })
	}
}
</script>