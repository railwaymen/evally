<template>
  <v-card class="pa-3">
    <v-card-title>
      <span class="headline">{{ $t('components.evaluations.completeForm.title') }}</span>
    </v-card-title>

    <v-form @submit.prevent="complete">
      <v-card-text>
        <p class="subtitle-1 text-center">
          {{ $t('components.evaluations.completeForm.question') }}<br>
          {{ $t('components.evaluations.completeForm.warning') }}
        </p>

        <v-menu
          ref="menu"
          v-model="menu"
          :close-on-content-click="false"
          :nudge-right="40"
          transition="scale-transition"
          offset-y
          min-width="290px"
        >
          <template v-slot:activator="{ on }">
            <v-text-field
              class="mt-4"
              :value="printableMonthDate"
              :label="$t('components.evaluations.completeForm.nextEvaluation')"
              prepend-inner-icon="mdi-calendar"
              readonly
              v-on="on"
            />
          </template>
          <v-date-picker
            v-model="monthDate"
            @input="menu = false"
            :min="hiredDate"
            :locale="$i18n.locale"
            type="month"
            no-title
            scrollable
          />
        </v-menu>
      </v-card-text>

      <v-card-actions>
        <v-spacer />

        <v-btn
          @click="closeDialog"
          color="grey darken-1"
          text
        >
          {{ $t('shared.buttons.cancel') }}
        </v-btn>
        <v-btn
          type="submit"
          color="green darken-1"
          text
        >
          {{ $t('shared.buttons.complete') }}
        </v-btn>
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script>
export default {
  name: 'CompleteForm',
  props: {
    defaultDate: {
      format: String,
      required: true,
      default: ''
    },
    hiredDate: {
      format: String,
      required: true,
      default: ''
    }
  },
  data() {
    return {
      menu: false,
      localDate: this.defaultDate,
    }
  },
  methods: {
    closeDialog() {
      this.$emit('closeDialog')
    },
    complete() {
      this.$store.dispatch(
        'EvaluationEmployablesModule/completeEvaluation', this.localDate.format('YYYY-MM-DD')
      ).then(() => this.closeDialog())
    }
  },
  computed: {
    monthDate: {
      get() {
        return this.localDate ? this.$moment(this.localDate).format('YYYY-MM') : ''
      },
      set(date) {
        this.localDate = this.$moment(date, 'YYYY-MM')
      }
    },
    printableMonthDate() {
      const mDate = this.$moment(this.monthDate, 'YYYY-MM')

      return mDate.isValid() ? mDate.format('MMMM YYYY') : ''
    }
  }
}
</script>
