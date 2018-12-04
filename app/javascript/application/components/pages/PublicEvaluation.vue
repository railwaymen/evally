<template>
  <section class="public-section" v-if="evaluation.isExisting()">
    <div class="public-section__bg"></div>

    <div class="public-section__content">
      <div class="auth-form elevation-2" v-if="!visible">
        <div class="auth-form__logo">
          <img src="@/assets/img/logo2_black.png" alt="Logo Evally">
        </div>

        <p class="auth-form__info">Please enter your last name to see the latest evaluation</p>

        <v-form ref="accessForm" v-model="valid" @submit.prevent="enter">
          <div class="auth-form__group">
            <v-text-field
              v-model="lastName"
              :rules="rules"
            ></v-text-field>
          </div>

          <div class="auth-form__action mt-4">
            <v-btn color="primary" type="submit" outline block round>Enter</v-btn>
          </div>
        </v-form>
      </div>

      <v-container fluid v-else>
        <v-layout row>
          <v-flex xs12>
            <employee-evaluation-box class="elevation-2"></employee-evaluation-box>
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapGetters } from 'vuex'

import EmployeeEvaluationBox from '@/components/employees/EmployeeEvaluationBox'

export default {
  name: 'PublicEvaluation',
  components: { EmployeeEvaluationBox },
  data() {
    return {
      valid: false,
      lastName: '',
      visible: false,
      rules: [
        v => !!v || 'Field is required',
        v => (v && v === this.evaluation.employee.last_name) || 'Text is not correct. Try again'
      ]
    }
  },
  methods: {
    enter() {
      this.visible = this.$refs.accessForm.validate()
    }
  },
  computed: {
    ...mapGetters({
      evaluation: 'EvaluationsStore/evaluation'
    })
  },
  created() {
    this.$store.dispatch('EvaluationsStore/show', this.$route.params.id)
      .catch( error => {
        if (error.response && error.response.status === 404) {
          this.$router.push({ name: 'not_found_path' })
        }
      })
  },
  beforeDestroy() {
    this.$store.commit('EvaluationsStore/clear')
  }
}
</script>