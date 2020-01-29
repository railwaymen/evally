<template>
  <div class="box box--with-content">
    <div class="employees-search">
      <v-form ref="employeesSearch" class="browser-form">
        <div class="browser-form__skill">
          <v-select
            :items="skills"
            :label="$t('widgets.employees_browser.form.skill_input')"
            chips
          >
            <template #selection="{ data }">
              <v-chip :selected="data.selected">
                {{ data.item }}
              </v-chip>
            </template>

            <template #item="{ data }">
              {{ data.item }}
            </template>
          </v-select>
        </div>

        <div class="browser-form__comparator">
          <v-btn-toggle class="elevation-0">
            <v-btn value="lteq" large flat class="px-3 mx-1">&#8924;</v-btn>
            <v-btn value="eq" large flat class="px-3 mx-1">&#61;</v-btn>
            <v-btn value="gteq" large flat class="px-3 mx-1">&#8925;</v-btn>
          </v-btn-toggle>
        </div>

        <div class="browser-form__value">
          <v-rating length="3" hover clearable />
        </div>

        <div class="browser-form__action">
          <v-btn
            color="primary"
            type="submit"
            block
            flat
          >
            {{ $t('widgets.employees_browser.form.search') }}
          </v-btn>
        </div>
      </v-form>

      <div class="search-results">
        <v-data-table
          :headers="headers"
          :items="[]"
          :loading="false"
          :rows-per-page-items="perPageItems"
        >
          <template #items="props">
            <td>{{ props.item.fullname }}</td>
            <td>
              <v-rating length="3" :value="2" readonly />
            </td>
            <td class="text-xs-center">
              <v-tooltip left>
                <template #activator="{ on }">
                  <span v-on="on">{{ props.item.hiredAt }}</span>
                </template>
                <span>{{ props.item.employmentTime }}</span>
              </v-tooltip>
            </td>
            <td class="text-xs-center">{{ props.item.group }}</td>
            <td class="text-xs-center">{{ props.item.position }}</td>
            <td class="text-xs-center">{{ props.item.positionSetAt }}</td>
            <td class="text-xs-center">{{ props.item.latestEvaluationDate }}</td>
          </template>
        </v-data-table>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'EmployeesSearch',
  data() {
    return {
      skills: [],
      headers: [
        {
          text: 'Employee Name',
          value: 'fullname'
        },
        {
          text: 'Skill',
          value: 'skillValue'
        },
        {
          text: 'Hired At',
          value: 'hiredAt',
          align: 'center'
        },
        {
          text: 'Team',
          value: 'group',
          align: 'center'
        },
        {
          text: 'Position',
          value: 'position',
          align: 'center'
        },
        {
          text: 'Position Set At',
          value: 'positionSetAt',
          align: 'center'
        },
        {
          text: 'Latest Evaluation Date',
          value: 'latest_evaluation_date',
          align: 'center'
        }
      ],
      perPageItems: [10, 30, { text: '$vuetify.dataIterator.rowsPerPageAll' , value: -1 }]
    }
  }
}
</script>
