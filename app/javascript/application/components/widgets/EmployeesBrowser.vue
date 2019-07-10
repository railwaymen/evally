<template>
  <div class="box box--border-primary">
		<h3 class="box__header">{{ $t('widgets.employees_browser.title') }}</h3>

    <div class="box__body">
      <v-form ref="employeesBrowserForm" @submit.prevent="search" class="browser-form">
        <v-select
          class="browser-form__skill"
          @input="setGroup"
          v-model="query.name"
          :items="skillItems"
          :rules="[vRequired]"
          :label="$t('widgets.employees_browser.form.skill_input')"
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
            <v-rating v-show="query.group === 'rating'" v-model="query.value" length="3" hover clearable></v-rating>
          </div>
        </div>

        <div v-show="query.group === 'bool'" class="browser-form__buttons">
          <div class="browser-form__value">
            <v-btn-toggle v-show="query.group === 'bool'" v-model="query.value" class="elevation-0">
              <v-btn :value="0" large flat class="px-3 mx-1">{{ $t('widgets.employees_browser.form.no') }}</v-btn>
              <v-btn :value="1" large flat class="px-3 mx-1">{{ $t('widgets.employees_browser.form.yes') }}</v-btn>
            </v-btn-toggle>
          </div>
        </div>

        <div class="browser-form__action">
          <v-btn color="primary" type="submit" block flat>{{ $t('widgets.employees_browser.form.search') }}</v-btn>
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
                {{ props.item.skill.value ? $t('widgets.employees_browser.form.yes') : $t('widgets.employees_browser.form.no') }}
              </span>
            </td>
            <td>
              <v-tooltip bottom>
                <v-btn @click="showProfile(props.item.id)" slot="activator" color="grey" flat icon>
                  <v-icon>person</v-icon>
                </v-btn>
                <span>{{ $t('widgets.employees_browser.table.buttons.view_profile') }}</span>
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

import employment from '@/lib/mixins/employment'

export default {
  name: 'EmployeesBrowser',
  mixins: [employment],
  data() {
    return {
      query: {
        group: 'rating',
        name: '',
        comparator: 'eq',
        value: 0
      },
      headers: [
        { text: this.$t('widgets.employees_browser.table.headers.employee_name'), align: 'left', value: 'name' },
        { text: this.$t('widgets.employees_browser.table.headers.position'), value: 'position', align: 'center' },
        { text: this.$t('widgets.employees_browser.table.headers.experience'), value: 'experience', align: 'center' },
        { text: this.$t('widgets.employees_browser.table.headers.skill'), value: 'skill', align: 'center' },
        { text: this.$t('widgets.employees_browser.table.headers.actions'), value: 'name', sortable: false }
      ]
    }
  },
  methods: {
    search() {
      if (this.$refs.employeesBrowserForm.validate()) {
        this.$store.dispatch('BrowserStore/search', { query: this.query })
          .catch(error => {
            this.flash({ error: this.$root.$t('widgets.employees_browser.errors.browse', { reason: this.renderError(error.response) }) })
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
        output.push({ header: this.$t('widgets.employees_browser.form.rating') }, ...this.skills.rating)
      }

      if (this.skills.rating.length > 0 && this.skills.bool.length > 0) {
        output.push({ divider: true })
      }

      if (this.skills.bool.length > 0) {
        output.push({ header: this.$t('widgets.employees_browser.form.yes_no') }, ...this.skills.bool)
      }

      return output
    }
  },
  created() {
    this.$store.dispatch('BrowserStore/skills')
      .catch(error => {
        this.flash({ error: this.$root.$t('widgets.employees_browser.errors.fetch', { reason: this.renderError(error.response) }) })
      })

    this.query = this.$store.getters['BrowserStore/query']
  },
}
</script>
