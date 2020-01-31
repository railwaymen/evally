<template>
  <div class="box">
    <v-form ref="employeesSearch" class="search-form">
      <div class="search-form__skill">
        <v-select
          :items="skills"
          :label="$t('views.employeesSearch.label')"
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

      <div class="search-form__comparator">
        <v-btn-toggle class="elevation-0">
          <v-btn value="lteq" large flat class="px-3 mx-1">&#8924;</v-btn>
          <v-btn value="eq" large flat class="px-3 mx-1">&#61;</v-btn>
          <v-btn value="gteq" large flat class="px-3 mx-1">&#8925;</v-btn>
        </v-btn-toggle>
      </div>

      <div class="search-form__value">
        <v-rating length="3" hover clearable />
      </div>

      <div class="search-form__action">
        <v-btn
          color="primary"
          type="submit"
          block
          flat
        >
          {{ $t('shared.buttons.search') }}
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
</template>

<script>
export default {
  name: 'EmployeesSearch',
  data() {
    return {
      skills: [],
      headers: [
        {
          text: this.$t('views.employeesSearch.table.cols.name'),
          value: 'fullname'
        },
        {
          text: this.$t('views.employeesSearch.table.cols.skill'),
          value: 'skillValue'
        },
        {
          text: this.$t('views.employeesSearch.table.cols.hiredAt'),
          value: 'hiredAt',
          align: 'center'
        },
        {
          text: this.$t('views.employeesSearch.table.cols.group'),
          value: 'group',
          align: 'center'
        },
        {
          text: this.$t('views.employeesSearch.table.cols.position'),
          value: 'position',
          align: 'center'
        },
        {
          text: this.$t('views.employeesSearch.table.cols.positionSetAt'),
          value: 'positionSetAt',
          align: 'center'
        },
        {
          text: this.$t('views.employeesSearch.table.cols.latestEvaluationAt'),
          value: 'latest_evaluation_date',
          align: 'center'
        }
      ],
      perPageItems: [10, 30, { text: '$vuetify.dataIterator.rowsPerPageAll' , value: -1 }]
    }
  }
}
</script>
