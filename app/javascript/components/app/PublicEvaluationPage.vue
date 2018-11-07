<template>
  <section class="public-evaluation" v-if="evaluation.isExisting()">
    <v-container>
      <v-layout v-if="!visible" align-center justify-center row fill-height>
        <v-flex xs3>
          <v-card class="pa-4">
            <div class="access-form">
              <img class="access-form__logo" src="../../assets/img/logo2_black.png" alt="Logo Evally">

              <v-form ref="accessForm" v-model="valid" @submit.prevent="enter">
                <v-card-text>
                  <p class="subheading">Please enter your last name to see the latest evaluation</p>
                  <v-text-field
                    v-model="lastName"
                    :rules="rules"
                  ></v-text-field>
                </v-card-text>

                <v-card-actions>
                  <v-btn color="primary" type="submit" outline block>Enter</v-btn>
                </v-card-actions>
              </v-form>
            </div>
          </v-card>
        </v-flex>
      </v-layout>

      <v-layout v-else row>
        <v-flex xs3>
          <div class="sidebar">
            <router-link :to="{ name: 'landing_page_path' }">
              <img class="sidebar__logo" src="../../assets/img/logo2_black.png" alt="Logo Evally">
            </router-link>

            <div class="sidebar__actions pa-4">
              <!-- <v-btn color="primary" outline block>Download PDF</v-btn> -->

              <p class="homepage-link text-xs-center py-4">
                <router-link :to="{ name: 'landing_page_path' }">Go to homepage</router-link>
              </p>
            </div>
          </div>
        </v-flex>

        <v-flex xs9>
          <employee-evaluation-box></employee-evaluation-box>
        </v-flex>
      </v-layout>
    </v-container>
  </section>
</template>

<script>
import { mapGetters } from 'vuex'

import EmployeeEvaluationBox from './employees/EmployeeEvaluationBox'

export default {
  name: 'PublicEvaluationPage',
  components: { EmployeeEvaluationBox },
  data() {
    return {
      valid: false,
      lastName: '',
      visible: false,
      rules: [
        v => !!v || 'Last name is required',
        v => (v && v === this.evaluation.employee.last_name) || 'Last name is not correct. Try again'
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
    this.$store.commit('EvaluationsStore/clearEvaluation')
  }
}
</script>