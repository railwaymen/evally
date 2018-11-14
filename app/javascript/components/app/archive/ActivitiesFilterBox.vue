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
            v-model="from.menu"
            lazy
            transition="scale-transition"
            offset-y
            full-width
            min-width="290px"
          >
            <v-text-field
              slot="activator"
              v-model="from.date"
              label="From"
              readonly
            ></v-text-field>
            <v-date-picker v-model="from.date" @input="from.menu = false" no-title scrollable></v-date-picker>
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
            v-model="to.menu"
            lazy
            transition="scale-transition"
            offset-y
            full-width
            min-width="290px"
          >
            <v-text-field
              slot="activator"
              v-model="to.date"
              label="To"
              readonly
            ></v-text-field>
            <v-date-picker v-model="to.date" @input="to.menu = false" no-title scrollable></v-date-picker>
          </v-menu>
        </div>
      </div>

      <div class="filter-actions text-xs-right">
        <v-btn flat>Reset</v-btn>
        <v-btn color="primary" flat>Filter</v-btn>
      </div>
    </v-form>
  </div>
</template>

<script>
export default {
  name: 'ActivitiesFilterBox',
  data() {
    return {
      from: { menu: false, date: null },
      to: { menu: false, date: null }
    }
  }
}
</script>