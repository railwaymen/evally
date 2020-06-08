<template>
  <div class="datetime-field">
    <div class="datetime-field__date">
      <v-menu
        v-model="menu"
        :close-on-content-click="false"
        :nudge-right="40"
        transition="scale-transition"
        offset-y
        min-width="290px"
      >
        <template v-slot:activator="{ on }">
          <v-text-field
            :value="computedDate"
            :label="label"
            :rules="rules"
            prepend-inner-icon="mdi-calendar"
            append-icon="mdi-close"
            readonly
            v-on="on"
            @click:append="$emit('input', null)"
          />
        </template>
        <v-date-picker
          :value="computedDate"
          @input="updateDate"
          :locale="$i18n.locale"
          no-title
          scrollable
        />
      </v-menu>
    </div>

    <div class="datetime-field__time">
      <v-text-field
        v-mask="'##:##'"
        :value="computedTime"
        @blur="updateTime"
        :rules="rules"
        :disabled="!computedDate"
        prepend-inner-icon="mdi-clock-outline"
        placeholder="00:00"
      >
        <template #append>
          <v-tooltip bottom>
            <template #activator="{ on }">
              <span v-on="on">{{ timezoneToken }}</span>
            </template>

            <span>{{ timezone }}</span>
          </v-tooltip>
        </template>
      </v-text-field>
    </div>
  </div>
</template>

<script>
import { mask } from 'vue-the-mask'
import moment from 'moment-timezone'

import { currentTimezone } from '@utils/helpers'

export default {
  name: 'DatetimeField',
  directives: { mask },
  props: {
    value: {
      type: String,
      required: false,
      default: null
    },
    label: {
      type: String,
      required: false,
      default: null
    },
    rules: {
      type: Array,
      required: false,
      default: () => []
    }
  },
  data() {
    return {
      menu: false
    }
  },
  methods: {
    updateDate(value) {
      this.$emit('input', moment(`${value} ${this.computedTime || '00:00:00'}`).format())
      this.menu = false
    },
    updateTime(e) {
      let time = e.target.value

      if (!time.match(/^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/)) time = '00:00'
      this.$emit('input', moment(`${this.computedDate} ${time}:00`).format())
    }
  },
  computed: {
    computedDate() {
      return this.mDatetime ? this.mDatetime.format('YYYY-MM-DD') : ''
    },
    computedTime() {
      return this.mDatetime ? this.mDatetime.format('HH:mm') : ''
    },
    mDatetime() {
      const validDatetime = this.value && moment(this.value).isValid()
      return validDatetime ? moment(this.value) : null
    },
    timezoneToken() {
      return this.mDatetime ? this.mDatetime.tz(currentTimezone).format('z') : null
    },
    timezone() {
      return currentTimezone
    }
  }
}
</script>
