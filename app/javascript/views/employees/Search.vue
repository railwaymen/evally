<template>
  <div class="box">
    <v-form ref="form" @submit.prevent="search" class="search-form">
      <div class="search-form__skill">
        <v-select
          :value="query.name"
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
                {{ item.group === 'rating' ? 'mdi-star' : 'mdi-plus-minus' }}
              </v-icon>

              <span class="body-2">{{ item.name }}</span>
            </v-chip>
          </template>

          <template #item="{ item }">
            <v-icon size="14" class="mr-2">
              {{ item.group === 'rating' ? 'mdi-star' : 'mdi-plus-minus' }}
            </v-icon>

            <span class="body-2">{{ item.name }}</span>
          </template>
        </v-select>
      </div>

      <template v-if="query.isRating">
        <div class="search-form__buttons">
          <v-btn-toggle v-model="query.operator" color="primary" group>
            <v-btn value="lteq" text>
              <v-icon size="14">mdi-less-than-or-equal</v-icon>
            </v-btn>

            <v-btn value="eq" text>
              <v-icon size="14">mdi-equal</v-icon>
            </v-btn>

            <v-btn value="gteq" text>
              <v-icon size="14">mdi-greater-than-or-equal</v-icon>
            </v-btn>
          </v-btn-toggle>
        </div>

        <div class="search-form__value">
          <v-rating v-model="query.value" background-color="grey" length="3" hover clearable />
        </div>
      </template>

      <div v-if="query.isBool" class="search-form__buttons">
        <v-btn-toggle v-model="query.value" color="primary" group>
          <v-btn
            :value="false"
            text
          >
            {{ $t('shared.buttons.no') }}
          </v-btn>

          <v-btn
            :value="true"
            text
          >
            {{ $t('shared.buttons.yes') }}
          </v-btn>
        </v-btn-toggle>
      </div>

      <div class="search-form__action">
        <v-btn
          @click="reset"
          color="grey darken-1"
          type="submit"
          text
        >
          {{ $t('shared.buttons.reset') }}
        </v-btn>
        <v-btn
          color="primary"
          type="submit"
          text
        >
          {{ $t('shared.buttons.search') }}
        </v-btn>
      </div>
    </v-form>

    <div class="search-results">
      <search-table
        :employees="employees"
        :loading="loading"
      />
    </div>
  </div>
</template>

<script>
import { mapActions, mapState } from 'vuex'

import SearchTable from '@components/employees/SearchTable'

export default {
  name: 'EmployeesSearch',
  components: { SearchTable },
  methods: {
    ...mapActions('EmployeesSearchModule', [
      'searchEmployees',
      'fetchSkills'
    ]),
    setGroup(item) {
      if (item.group === 'bool') this.query.assign({ operator: 'eq', value: true })

      this.query.assign({ name: item.name, group: item.group, value: 0 })
    },
    reset() {
      this.$store.commit('EmployeesSearchModule/RESET_STATE')
      this.$refs.form.reset()
    },
    search() {
      if (this.$refs.form.validate()) this.searchEmployees(this.query)
    }
  },
  computed: {
    ...mapState('EmployeesSearchModule', [
      'skills',
      'query',
      'employees',
      'loading'
    ])
  },
  created() {
    this.fetchSkills()
  }
}
</script>
