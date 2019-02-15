<template>
  <div class="box box--border-primary">
		<h3 class="box__header">Browse</h3>

    <div class="box__body">
      <v-form ref="employeesBrowserForm" @submit.prevent="search" class="browser-form">
        <v-select
          class="browser-form__skill"
          @input="setGroup"
          v-model="query.name"
          :items="skillItems"
          :rules="[vRequired]"
          label="Skill"
          chips
        >
          <template slot="selection" slot-scope="data">
            <v-chip :selected="data.selected">
              {{ data.item }}
            </v-chip>
          </template>

          <template slot="item" slot-scope="data">
            {{ data.item }}
          </template>
        </v-select>

        <div v-show="query.group === 'rating'" class="browser-form__buttons">
          <div class="browser-form__comparator">
            <v-btn-toggle v-model="query.comparator" class="elevation-0">
              <v-btn value="lteq" large flat class="px-3 mx-1">&#8924;</v-btn>
              <v-btn value="eq" large flat class="px-3 mx-1">&#61;</v-btn>
              <v-btn value="gteq" large flat class="px-3 mx-1">&#8925;</v-btn>
            </v-btn-toggle>
          </div>

          <div class="browser-form__value">
            <v-rating v-show="query.group === 'rating'" v-model="query.value" length="3"></v-rating>
          </div>
        </div>

        <div v-show="query.group === 'bool'" class="browser-form__buttons">
          <div class="browser-form__value">
            <v-btn-toggle v-show="query.group === 'bool'" v-model="query.value" class="elevation-0">
              <v-btn :value="0" large flat class="px-3 mx-1">No</v-btn>
              <v-btn :value="1" large flat class="px-3 mx-1">Yes</v-btn>
            </v-btn-toggle>
          </div>
        </div>

        <div class="browser-form__action">
          <v-btn color="primary" type="submit" block flat>Search</v-btn>
        </div>
      </v-form>

      <div class="py-4">
        <v-data-table
          :headers="headers"
          :items="results.models"
          :loading="isLoading"
          :custom-sort="customSort"
        >
          <v-progress-linear slot="progress" color="blue" indeterminate></v-progress-linear>
          <template slot="items" slot-scope="props">
            <td>{{ props.item.fullname() }}</td>
            <td class="text-xs-center">{{ props.item.position }}</td>
            <td class="text-xs-center">{{ employment(props.item.hired_at) }}</td>
            <td class="text-xs-center">
              <v-rating v-if="isRating(props.item.skill.value)" length="3" :value="props.item.skill.value" readonly></v-rating>
              <span v-if="isBool(props.item.skill.value)">
                {{ props.item.skill.value ? `Yes` : `No` }}
              </span>
            </td>
            <td>
              <v-tooltip bottom>
                <v-btn @click="showProfile(props.item.id)" slot="activator" color="grey" flat icon>
                  <v-icon>person</v-icon>
                </v-btn>
                <span>View profile</span>
              </v-tooltip>
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
      query: {
        group: 'rating',
        name: '',
        comparator: 'eq',
        value: 0
      },
      headers: [
        { text: 'Employee name', align: 'left', value: 'name' },
        { text: 'Position', value: 'position', align: 'center' },
        { text: 'Experience', value: 'experience', align: 'center' },
        { text: 'Skill', value: 'skill', align: 'center' },
        { text: 'Actions', value: 'name', sortable: false }
      ]
    }
  },
  methods: {
    search() {
      if (this.$refs.employeesBrowserForm.validate()) {
        this.$store.dispatch('BrowserStore/search', { query: this.query })
          .catch(error => {
            this.flash({ error: 'Browser error' })
          })
      }
    },

    setGroup() {
      if (this.skills.bool.indexOf(this.query.name) > -1) {
        this.query.group = 'bool'
        this.query.comparator = 'eq'
        this.query.value = 1
      } else {
        this.query.group = 'rating'
        this.query.value = 0
      }
    },

    showProfile(id) {
      this.$store.commit('EmployeesStore/pick', id)
      this.$router.push({ name: 'employees_path' })

      this.$vuetify.goTo(0)
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
    },

    isBool(val) {
      return this.$_.isBoolean(val)
    },

    isRating(val) {
      return this.$_.isNumber(val)
    },

    customSort(items, index, isDescending) {
      items.sort((a, b) => {
        switch(index) {
          case 'experience':
            if (isDescending) {
              return this.$moment(b.hired_at).format('YYYYMMDD') - this.$moment(a.hired_at).format('YYYYMMDD')
            } else {
              return this.$moment(a.hired_at).format('YYYYMMDD') - this.$moment(b.hired_at).format('YYYYMMDD')
            }
            break
          case 'skill':
            if (this.isBool(a.skill.value) || this.isBool(b.skill.value)) break
            return isDescending ? a.skill.value - b.skill.value : b.skill.value - a.skill.value
            break
          case 'name':
            return isDescending ? b.fullname().localeCompare(a.fullname()) : a.fullname().localeCompare(b.fullname())
            break
          case 'position':
            return isDescending ? b.position.localeCompare(a.position) : a.position.localeCompare(b.position)
            break
        }
      })

      return items
    }
  },
  computed: {
    ...mapGetters({
      skills: 'BrowserStore/skills',
      results: 'BrowserStore/results',
      status: 'BrowserStore/status'
    }),

    skillItems() {
      let output = []

      if (this.skills.rating.length > 0) {
        output.push({ header: 'Rating' }, ...this.skills.rating)
      }

      if (this.skills.rating.length > 0 && this.skills.bool.length > 0) {
        output.push({ divider: true })
      }

      if (this.skills.bool.length > 0) {
        output.push({ header: 'Yes / No' }, ...this.skills.bool)
      }

      return output
    }
  },
  created() {
    this.$store.dispatch('BrowserStore/skills')
      .catch(error => {
        this.flash({ error: 'Skills cannot be loaded due to some error.' })
      })
    
    this.query = this.$store.getters['BrowserStore/query']
  },  
}
</script>