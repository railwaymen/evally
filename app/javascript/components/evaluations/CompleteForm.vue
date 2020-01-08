<template>
  <v-card class="pa-3">
    <v-card-title>
      <span class="headline">{{ $t('evaluations.forms.complete.title') }}</span>
    </v-card-title>

    <v-form @submit.prevent="complete">
      <v-card-text>
        <p class="subheading text-xs-center">
          {{ $t('evaluations.forms.complete.question') }}<br>
          {{ $t('evaluations.forms.complete.warning') }}
        </p>

        <div class="date">
          <v-menu
            ref="menu"
            v-model="menu"
            :close-on-content-click="false"
            :nudge-right="40"
            lazy
            transition="scale-transition"
            offset-y
            full-width
            min-width="290px"
          >
            <template v-slot:activator="{ on }">
              <v-text-field
                :value="$moment(computedDate).format('MMMM YYYY')"
                :label="$t('evaluations.forms.complete.next_label')"
                prepend-icon="event"
                readonly
                v-on="on"
              />
            </template>
            <v-date-picker
              v-model="date"
              @change="menu = false"
              :locale="$i18n.locale"
              type="month"
              no-title
              scrollable
            />
          </v-menu>
        </div>
      </v-card-text>

      <v-card-actions>
        <v-spacer />
        <v-btn color="grey darken-1" flat @click="closeDialog">{{ $t('buttons.cancel') }}</v-btn>
        <v-btn type="submit" color="green darken-1" flat>{{ $t('buttons.complete') }}</v-btn>
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'CompleteForm',
  data() {
    return {
      menu: false,
      date: null,
    }
  },
  methods: {
    closeDialog() {
      this.$emit('closeDialog')
    },
    complete() {
      this.$store.dispatch(
        'EvaluationsStore/complete',
        { nextEvaluationDate: this.computedDate.format('YYYY-MM') }
      ).finally(() => this.closeDialog())
    }
  },
  computed: {
    ...mapGetters({
      setting: 'AuthStore/setting'
    }),
    computedDate: {
      get() {
        return this.date || this.$moment().add(this.setting.default_next_evaluation_time, 'M')
      },
      set(date) {
        this.date = date
      }
    }
  }
}
</script>
