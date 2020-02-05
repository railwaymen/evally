<template>
  <div class="box">
    <v-form ref="form" @submit.prevent="search" class="search-form">
      <div class="search-form__skill">
        <v-select
          @change="setGroup"
          :items="skills"
          item-text="name"
          item-value="name"
          :rules="[vRequired]"
          :label="$t('views.employees.search.label')"
          return-object
          chips
        >
          <template #selection="{ item }">
            <v-chip>
              <v-icon size="14" class="mr-2">
                {{ item.group === 'rating' ? 'star' : 'exposure' }}
              </v-icon>
              {{ item.name }}
            </v-chip>
          </template>

          <template #item="{ item }">
            <v-icon size="14" class="mr-2">
              {{ item.group === 'rating' ? 'star' : 'exposure' }}
            </v-icon>

            {{ item.name }}
          </template>
        </v-select>
      </div>

      <template v-if="query.isRating">
        <div class="search-form__buttons">
          <v-btn-toggle v-model="query.operator" class="elevation-0">
            <v-btn
              class="px-3 mx-1"
              value="lteq"
              large
              flat
            >
              &#8924;
            </v-btn>

            <v-btn
              class="px-3 mx-1"
              value="eq"
              large
              flat
            >
              &#61;
            </v-btn>

            <v-btn
              class="px-3 mx-1"
              value="gteq"
              large
              flat
            >
              &#8925;
            </v-btn>
          </v-btn-toggle>
        </div>

        <div class="search-form__value">
          <v-rating v-model="query.value" length="3" hover clearable />
        </div>
      </template>

      <div v-if="query.isBool" class="search-form__buttons">
        <v-btn-toggle v-model="query.value" class="elevation-0">
          <v-btn
            :value="false"
            large
            flat
            class="px-3 mx-1"
          >
            {{ $t('shared.buttons.no') }}
          </v-btn>

          <v-btn
            :value="true"
            large
            flat
            class="px-3 mx-1"
          >
            {{ $t('shared.buttons.yes') }}
          </v-btn>
        </v-btn-toggle>
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
        :items="employees.models"
        :loading="false"
        :rows-per-page-items="perPageItems"
      >
        <template #items="props">
          <td>{{ props.item.fullname }}</td>
          <td>
            <v-rating
              v-if="props.item.skill.group === 'rating'"
              :value="props.item.skill.value"
              length="3"
              readonly
            />

            <v-chip v-if="props.item.skill.group === 'bool'">
              {{ props.item.skill.value ? $t('shared.buttons.yes') : $t('shared.buttons.no') }}
            </v-chip>
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
import { mapGetters } from 'vuex'

export default {
  name: 'EmployeesSearch',
  data() {
    return {
      headers: [
        {
          text: this.$t('views.employees.search.table.cols.name'),
          value: 'fullname'
        },
        {
          text: this.$t('views.employees.search.table.cols.skill'),
          value: 'skill.value'
        },
        {
          text: this.$t('views.employees.search.table.cols.hiredAt'),
          value: 'hired_at',
          align: 'center'
        },
        {
          text: this.$t('views.employees.search.table.cols.group'),
          value: 'group',
          align: 'center'
        },
        {
          text: this.$t('views.employees.search.table.cols.position'),
          value: 'position',
          align: 'center'
        },
        {
          text: this.$t('views.employees.search.table.cols.positionSetAt'),
          value: 'position_set_at',
          align: 'center'
        },
        {
          text: this.$t('views.employees.search.table.cols.latestEvaluationAt'),
          value: 'latest_evaluation_date',
          align: 'center'
        }
      ],
      perPageItems: [10, 30, { text: '$vuetify.dataIterator.rowsPerPageAll' , value: -1 }]
    }
  },
  methods: {
    setGroup(item) {
      if (item.group === 'bool') this.query.assign({ operator: 'eq', value: true })

      this.query.assign({ name: item.name, group: item.group, value: 0 })
    },
    search() {
      if (this.$refs.form.validate()) {
        this.$store.dispatch('EmployeesSearchModule/search', this.query)
      }
    }
  },
  computed: {
    ...mapGetters({
      skills: 'EmployeesSearchModule/skills',
      query: 'EmployeesSearchModule/query',
      employees: 'EmployeesSearchModule/employees',
      loading: 'EmployeesSearchModule/loading'
    })
  },
  created() {
    this.$store.dispatch('EmployeesSearchModule/skills')
  }
}
</script>
