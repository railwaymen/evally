<template>
  <div class="box">
    <div class="box__list">
      <v-list subheader>
        <v-subheader>Evaluations drafts</v-subheader>

        <v-list-tile v-for="draft in drafts.models" :key="draft.id">
          <v-list-tile-action>
            <v-icon>person_outline</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>{{ `${draft.employee.first_name} ${draft.employee.last_name}` }}</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>

        <v-list-tile v-if="drafts.models.length == 0">
          <v-list-tile-action>
            <v-icon>error_outline</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>There are no evaluations drafts</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'EvaluationDraftsBox',
  data () {
    return {

    }
  },
  computed: {
    ...mapGetters({
      drafts: 'EvaluationsStore/drafts',
    })
  },
  mounted() {
    if (this.drafts.models.length === 0) {
      this.$store.dispatch('EvaluationsStore/index')
        .catch( error => {
          this.flash({ error: 'Draft evaluations cannot be loaded due to some error: ' + error.message })
        })
    }
  }

}
</script>
