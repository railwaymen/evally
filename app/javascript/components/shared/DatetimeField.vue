<template>
  <div class="datetime-field">
    <div class="datetime-field__date">
      <v-menu
        :close-on-content-click="true"
        :nudge-right="40"
        transition="scale-transition"
        offset-y
        min-width="290px"
      >
        <template v-slot:activator="{ on }">
          <v-text-field
            :value="computedDate"
            :label="label"
            :rules="[vRequired]"
            prepend-inner-icon="mdi-calendar"
            clearable
            readonly
            v-on="on"
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
        :rules="[vRequired]"
        :disabled="!datetime"
        prepend-inner-icon="mdi-clock-outline"
      />
    </div>
  </div>
</template>

<script>
import { mask } from 'vue-the-mask'

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
    }
  },
  data() {
    return {
      datetime: this.value
    }
  },
  methods: {
    updateDate(value) {
      this.datetime = this.$moment(`${value} ${this.computedTime || '00:00:00'}`).format()
    },
    updateTime(e) {
      let time = e.target.value

      if (!time.match(/^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/)) time = '00:00'
      this.datetime = this.$moment(`${this.computedDate} ${time}:00`).format()
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
      const validDatetime = this.datetime && this.$moment(this.datetime).isValid()
      return validDatetime ? this.$moment(this.datetime) : null
    }
  },
  watch: {
    datetime(newVal) {
      this.$emit('input', newVal)
    }
  }
}
</script>
