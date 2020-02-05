<template>
  <v-layout row wrap>
    <v-flex xs12>
      <div class="widget widget--border-primary">
        <h3 class="widget__header">
          Employees by Positions
        </h3>

        <div class="widget__body">
          <groups-chart />
        </div>
      </div>
    </v-flex>
  </v-layout>
</template>

<script>
import GroupsChart from '@components/employees/GroupsChart'

export default {
  name: 'EmployeesOverview',
  components: { GroupsChart }
}
</script>
