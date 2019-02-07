<template>
  <div class="box box--border-primary">
		<h3 class="box__header">Browse</h3>

    <div class="box__body">
      <v-form ref="employeesBrowserForm" @submit.prevent="search" class="browser-form">
        <v-layout row wrap>
          <v-flex xs5>
            <v-select
              @input="selectSkill"
              :items="skillItems"
              :rules="[vRequired]"
              item-text="name"
              chips
              return-object
              label="Skill"
            >
              <template slot="selection" slot-scope="data">
                <v-chip :selected="data.selected">
                  {{ data.item.name }}
                </v-chip>
              </template>

              <template slot="item" slot-scope="data">
                {{ data.item.name }}
              </template>
            </v-select>
          </v-flex>

          <v-flex xs5>
            <div v-show="query.group === 'rating'" class="browser-form__grade">
              <v-btn-toggle v-model="query.comparator" class="elevation-0">
                <v-btn value="lteq" large flat class="px-3 mx-1">&#8924;</v-btn>
                <v-btn value="eq" large flat class="px-3 mx-1">&#61;</v-btn>
                <v-btn value="gteq" large flat class="px-3 mx-1">&#8925;</v-btn>
              </v-btn-toggle>
              <v-rating class="d-inline-block" v-model="query.value" length="3"></v-rating>
              <span class="browser-form__grade--suffix">stars</span>
            </div>

            <div v-show="query.group === 'bool'" class="browser-form__grade">
              <v-btn-toggle v-model="query.value" class="elevation-0">
                <v-btn :value="false" large flat class="px-3 mx-1">No</v-btn>
                <v-btn :value="true" large flat class="px-3 mx-1">Yes</v-btn>
              </v-btn-toggle>
            </div>
          </v-flex>

          <v-flex xs2>
            <div class="browser-form__action">
              <v-btn color="primary" type="submit" block flat>Search</v-btn>
            </div>
          </v-flex>
        </v-layout>
      </v-form>

      <div class="py-4">
        <v-data-table
          :headers="headers"
          :items="results.models"
        >
          <template slot="items" slot-scope="props">
            <td>{{ props.item.fullname() }}</td>
            <td class="text-xs-center">{{ props.item.position }}</td>
            <td class="text-xs-center">{{ employment(props.item.hired_at) }}</td>
            <td class="text-xs-center">
              <v-rating length="3" :value="props.item.skill.value"></v-rating>
            </td>
            <td class="text-xs-center">
              <v-icon
                small
              >
                list_alt
              </v-icon>
            </td>
          </template>
        </v-data-table>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'EmployeesBrowser',
  data() {
    return {
      headers: [
        { text: 'Employee name', align: 'left', value: 'name' },
        { text: 'Position', value: 'position', align: 'center' },
        { text: 'Experience', value: 'experience', align: 'center' },
        { text: 'Skill', value: 'skill', align: 'center' },
        { text: 'Actions', value: 'name' }
      ]
    }
  },
  methods: {
    search() {
      if (this.$refs.employeesBrowserForm.validate()) {
        console.log(this.query)

        this.$store.dispatch('BrowserStore/search', { query: this.query })
          .catch(error => {
            this.flash({ error: 'Browser error' })
          })
      }
    },

    selectSkill(skill) {
      if (skill.group === 'bool') {
        this.query.comparator = 'eq'
        this.query.value = true
      }

      this.query.name = skill.name
      this.query.group = skill.group
    },

    employment(hired_at) {
      let diff = this.$moment().diff(hired_at, 'days')

      let days = diff % 365
      let years = Math.floor(diff / 365)

      let result = [days, this.daysSuffix(days)]
      if (years > 0) result.unshift(years, this.yearsSuffix(years), 'and')

      return result.join(' ')
    },

    daysSuffix(n) {
      return n === 1 ? 'day' : 'days'
    },

    yearsSuffix(n) {
      return n === 1 ? 'year' : 'years'
    }
  },
  computed: {
    ...mapGetters({
      skillItems: 'BrowserStore/skills',
      results: 'BrowserStore/results',
      query: 'BrowserStore/query'
    })
  },
  created() {
    this.$store.dispatch('BrowserStore/skills')
      .catch(error => {
        this.flash({ error: 'Skills error' })
      })
  },  
}
</script>