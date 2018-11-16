<template>
  <div class="box mt-2 pa-4">

    <v-form>
      <div class="filter">
        <div class="filter__title">
          <h3>Filter by date</h3>
        </div>

        <div class="filter__icon pa-2">
          <v-icon>first_page</v-icon>
        </div>

        <div class="filter__input">
          <v-menu
            :close-on-content-click="false"
            v-model="menus.from"
            lazy
            transition="scale-transition"
            offset-y
            full-width
            min-width="290px"
          >
            <v-text-field
              slot="activator"
              v-model="datesRange.from"
              label="From"
              readonly
            ></v-text-field>
            <v-date-picker
              v-model="datesRange.from"
              @input="menus.from = false"
              :max="$moment().format('YYYY-MM-DD')"
              no-title scrollable
            ></v-date-picker>
          </v-menu>
        </div>
      </div>

      <div class="filter">
        <div class="filter__icon pa-2">
          <v-icon>last_page</v-icon>
        </div>

        <div class="filter__input">
          <v-menu
            :close-on-content-click="false"
            v-model="menus.to"
            lazy
            transition="scale-transition"
            offset-y
            full-width
            min-width="290px"
          >
            <v-text-field
              slot="activator"
              v-model="datesRange.to"
              label="To"
              readonly
            ></v-text-field>
            <v-date-picker
              v-model="datesRange.to"
              @input="menus.to = false"
              :max="$moment().format('YYYY-MM-DD')"
              no-title scrollable
            ></v-date-picker>
          </v-menu>
        </div>
      </div>

      <div class="filter-actions text-xs-right">
        <v-btn @click="resetFilter" flat>Reset</v-btn>
        <v-btn @click="refilter" color="primary" flat>Filter</v-btn>
      </div>
    </v-form>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'ActivitiesFilterBox',
  data() {
    return {
      menus: { from: false, to: false }
    }
  },
  methods: {
    refilter() {
      this.$store.commit('ActivitiesStore/setDatesRange', {
        from: this.datesRange.from,
        to: this.datesRange.to
      })

      this.$store.dispatch('ActivitiesStore/index')
        .catch(error => {
          this.flash({ error: 'Activities cannot be loaded due to some error: ' + this.renderError(error.response) })
        })
    },
    resetFilter() {
      this.$store.commit('ActivitiesStore/setDatesRange', {
        from: this.$moment().subtract(7, 'd').format('YYYY-MM-DD'),
        to: this.$moment().format('YYYY-MM-DD')
      })
    }
  },
  computed: {
    ...mapGetters({
      datesRange: 'ActivitiesStore/datesRange'
    })
  },
  created() {
    this.resetFilter()
  }
}
</script>