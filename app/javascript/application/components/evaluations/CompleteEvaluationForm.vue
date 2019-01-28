<template>
  <v-card class="pa-4">
    <v-card-title>
      <span class="headline">{{ $t('evaluations.forms.complete.title') }}</span>
    </v-card-title>

    <v-form>
      <v-card-text>
        <p class="subheading text-xs-center">
          {{ $t('evaluations.forms.complete.question') }}<br>
          {{ $t('evaluations.forms.complete.warning') }}
        </p>

        <div class="date">
          <v-menu
            ref="menu1"
            :close-on-content-click="false"
            v-model="menu1"
            :nudge-right="40"
            :return-value.sync="formattedDate"
            lazy
            transition="scale-transition"
            offset-y
            full-width
            min-width="290px"
          >
            <v-text-field
              slot="activator"
              v-model="formattedDate"
              :label="$t('evaluations.forms.complete.next_label')"
              append-icon="event"
              readonly
            ></v-text-field>
            <v-date-picker
              type="month"
              v-model="next_evaluation_at"
              @input="$refs.menu1.save(next_evaluation_at)"
              :locale="$i18n.locale"
              :min="$moment().format()"
              no-title scrollable></v-date-picker>
          </v-menu>
        </div>
      </v-card-text>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="grey darken-1" flat @click="$emit('close')">{{ $t('buttons.cancel') }}</v-btn>
        <v-btn color="green darken-1" flat @click="saveEvaluation">{{ $t('buttons.complete') }}</v-btn>
      </v-card-actions>
    </v-form>

  </v-card>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'CompleteEvaluationForm',
  props: { options: Object },
  data() {
    return {
      menu1: false,
      next_evaluation_at: null
    }
  },
  methods: {
    saveEvaluation() {
      this.evaluation.set('state', 'completed')
      this.evaluation.set('completed_at', this.$moment().utc().format())

      let params = {
        evaluation: {
          ...this.evaluation.withoutEmployee(),
          next_evaluation_at: this.next_evaluation_at || this.formattedDate
        }
      }

      this.$store.dispatch('EvaluationsStore/update', params)
        .then(() => {
          this.flash({ success: this.$root.$t('evaluations.flashes.complete.success') })
          this.$store.commit('EvaluationsStore/clear')
          this.$emit('close')
        })
        .catch(error => {
          this.flash({ error: this.$root.$t('evaluations.flashes.complete.error', { reason: this.renderError(error.response) }) })
        })
    }
  },
  computed: {
    ...mapGetters({
      evaluation: 'EvaluationsStore/evaluation',
      setting: 'AuthStore/setting'
    }),

    formattedDate: {
      get() {
        let date = this.next_evaluation_at ?
          this.$moment(this.next_evaluation_at) :
          this.$moment().add(this.setting.default_next_evaluation_time, 'M')

        return date.format('MMMM YYYY')
      },

      set(date) {
        this.next_evaluation_at = this.$moment(date, 'YYYY-MM').format()
      }
    }
  }
}
</script>
