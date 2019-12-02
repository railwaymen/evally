<template>
  <div class="box box--border-primary">
		<h3 class="box__header">Positions history</h3>

    <v-list two-line>
      <v-list-tile v-for="change in employee.position_changes" :key="change.id">
        <v-list-tile-content>
          <v-list-tile-title>{{ change.current_position }}</v-list-tile-title>
          <v-list-tile-sub-title class="text--primary">{{ change.changed_at  | moment("MMMM YYYY") }}</v-list-tile-sub-title>
          <v-list-tile-sub-title>Previous: {{ change.previous_position }}</v-list-tile-sub-title>
        </v-list-tile-content>
      </v-list-tile>

      <v-list-tile>
        <v-list-tile-content>
          <v-list-tile-title>Hired at {{ employee.hired_at  | moment("MMMM YYYY") }}</v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>
    </v-list>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'PositionsHistory',
  computed: {
    ...mapGetters({
      employee: 'EmployeesStore/employee',
    })
  }
}
</script>
