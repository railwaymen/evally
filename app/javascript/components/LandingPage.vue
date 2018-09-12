<template>
  <section class="landing-section">
    <div class="landing__box">
      <v-layout row fill-height>

        <v-flex v-if="currentPanel === 'register'" xs4>
          <div class="landing__box-panel landing__box-panel--left">
            <div class="landing__logo">
              <img src="../assets/img/logo_white.png" alt="Logo Evally">
            </div>
            <register-form @toggle="switchPanels"></register-form>
          </div>
        </v-flex>

        <v-flex xs8>
          <div class="landing__bg"></div>
        </v-flex>

        <v-flex v-if="currentPanel === 'login'" xs4>
          <div class="landing__box-panel landing__box-panel--right">
            <div class="landing__logo">
              <img src="../assets/img/logo_black.png" alt="Logo Evally">
            </div>
            <login-form @toggle="switchPanels"></login-form>
          </div>
        </v-flex>

      </v-layout>

    </div>
  </section>
</template>

<script>
import LoginForm from './forms/LoginForm'
import RegisterForm from './forms/RegisterForm'

export default {
  name: 'LandingPage',
  components: {
    LoginForm,
    RegisterForm
  },
  data () {
    return {
      currentPanel: 'login'
    }
  },
  methods: {
    switchPanels (target) {
      this.currentPanel = target
    }
  }
}
</script>
