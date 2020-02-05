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
      <search-table
        :employees="employees"
        :loading="loading"
      />
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

import SearchTable from '@components/employees/SearchTable'

export default {
  name: 'EmployeesSearch',
  components: { SearchTable },
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
