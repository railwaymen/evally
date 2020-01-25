<template>
  <div class="employees-overview">
    <v-layout row>
      <v-flex xs12>
        <groups-chart />
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import GroupsChart from '@components/employees/GroupsChart'

export default {
  name: 'EmployeesOverview',
  components: { GroupsChart }
}
</script>
