<template>
  <div class="box box--border-primary">
		<h3 class="box__header">Employment time</h3>

    <div class="employment">
      <div class="employment__average">
        <h3>2 years 187 days</h3>
        <p>avarage</p>
      </div>
      
      <div class="box__body">
        <div class="text-xs-center">
          <v-btn flat>Shortest</v-btn>
          <v-btn color="primary" flat>Longest</v-btn>
        </div>
        <v-list two-line>
          <v-list-tile v-for="(employee, index) in employees" :key="employee.id" avatar>
            <v-list-tile-content>
              <v-list-tile-title>
                {{ index + 1 }}. <strong>{{ employee.fullname }}</strong>
                {{ $t('dashboard.common.as') }}
                <em>{{ employee.position }}</em>
              </v-list-tile-title>
              <v-list-tile-sub-title>{{ employee.employment }}</v-list-tile-sub-title>
            </v-list-tile-content>

            <v-list-tile-action>
              <div class="">
                <v-tooltip bottom>
                  <v-btn slot="activator" color="grey" flat icon>
                    <v-icon>person</v-icon>
                  </v-btn>
                  <span>See profile</span>
                </v-tooltip>
              </div>
            </v-list-tile-action>
          </v-list-tile>
        </v-list>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'EmploymentTime',
  data() {
    return {
      employees: [
        { id: 1, fullname: 'Jack Sparrow', position: 'Ruby Developer', employment: '8 years 245 days' },
        { id: 2, fullname: 'Tony Start', position: 'QA Engineer', employment: '8 years 12 days' },
        { id: 3, fullname: 'Frank Underwood', position: 'Sales Manager', employment: '7 years 180 days' },
        { id: 4, fullname: 'Rocky Balboa', position: 'Security Manager', employment: '5 years 360 days' },
        { id: 5, fullname: 'Buzz Astral', position: 'R&D Manager', employment: '5 years 112 days' }
      ]
    }
  }
}
</script>