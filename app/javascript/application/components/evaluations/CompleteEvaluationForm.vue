<template>
  <v-card class="pa-4">
    <v-card-title>
      <span class="headline">{{ options.action | capitalize }} {{ options.model }}</span>
    </v-card-title>

    <v-form>
      <v-card-text>
        <p class="subheading text-xs-center">Are you sure you want to complete this {{ options.model }}?<br>This action <b>cannot</b> be undo.</p>

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
              label="Next evaluation at"
              append-icon="event"
              readonly
            ></v-text-field>
            <v-date-picker
              type="month"
              v-model="next_evaluation_at"
              @input="$refs.menu1.save(next_evaluation_at)"
              :min="$moment().format()"
              no-title scrollable></v-date-picker>
          </v-menu>
        </div>
      </v-card-text>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="grey darken-1" flat @click="$emit('close')">Cancel</v-btn>
        <v-btn color="green darken-1" flat @click="saveEvaluation">{{ options.action }}</v-btn>
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
      next_evaluation_at: this.$moment().add(6, 'M').format()
    }
  },
  methods: {
    saveEvaluation() {
      this.evaluation.state = 'completed'
      this.evaluation.completed_at = this.$moment().utc().format()

      let params = {
        evaluation: {
          ...this.evaluation.attributes,
          next_evaluation_at: this.next_evaluation_at
        }
      }

      this.$store.dispatch('EvaluationsStore/update', params)
        .then(() => {
          this.flash({ success: `Evaluation has been succefully completed` })
          this.$store.commit('EvaluationsStore/clear')
          this.$emit('close')
        })
        .catch(error => {
          this.flash({ error: 'Template cannot be completed due to some error: ' + this.renderError(error.response) })
        })
    }
  },
  computed: {
    ...mapGetters({
      evaluation: 'EvaluationsStore/evaluation'
    }),

    formattedDate: {
      get() {
        return this.$moment(this.next_evaluation_at).format('MMMM YYYY')
      },

      set(date) {
        this.next_evaluation_at = this.$moment(date, 'YYYY-MM').format()
      }
    }
  }
}
</script>
