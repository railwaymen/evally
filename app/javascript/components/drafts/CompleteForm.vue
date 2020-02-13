<template>
  <v-card class="pa-3">
    <v-card-title>
      <span class="headline">{{ $t('components.drafts.completeForm.title') }}</span>
    </v-card-title>

    <v-form @submit.prevent="complete">
      <v-card-text>
        <p class="subtitle-1 text-center">
          {{ $t('components.drafts.completeForm.question') }}<br>
          {{ $t('components.drafts.completeForm.warning') }}
        </p>

        <v-menu
          ref="menu"
          v-model="menu"
          :close-on-content-click="true"
          :nudge-right="40"
          transition="scale-transition"
          offset-y
          min-width="290px"
        >
          <template v-slot:activator="{ on }">
            <v-text-field
              class="mt-4"
              :value="$moment(computedDate).format('MMMM YYYY')"
              :label="$t('components.drafts.completeForm.nextEvaluation')"
              prepend-icon="mdi-calendar-month"
              readonly
              v-on="on"
            />
          </template>
          <v-date-picker
            v-model="date"
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
        'DraftsModule/complete',
        { nextEvaluationDate: this.computedDate.format('YYYY-MM') }
      ).then(() => this.closeDialog())
    }
  },
  computed: {
    ...mapGetters({
      setting: 'SessionModule/setting'
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
