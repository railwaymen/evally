<template>
  <div class="auth-form elevation-2">
    <div class="auth-form__logo">
      <img src="@/assets/img/logo2_black.png" alt="Logo Evally">
    </div>

    <h3 class="auth-form__heading auth-form__heading--dark mb-4">sign in</h3>

    <v-form ref="loginForm" v-model="formValid" @submit.prevent="login">

      <div class="auth-form__group">
        <v-text-field
          v-model="credentials.email"
          prepend-icon="alternate_email"
          type="email"
          label="email"
        ></v-text-field>
        <v-text-field
          v-model="credentials.password"
          prepend-icon="lock"
          type="password"
          label="password"
        ></v-text-field>
      </div>

      <div class="auth-form__action mt-4">
        <v-btn color="primary" type="submit" flat outline round block>Sign in</v-btn>
      </div>

      <div class="auth-form__question">
        <p style="display: none;">
          No account?
          <span class="primary--text">Sign up</span>
        </p>
      </div>
    </v-form>
  </div>
</template>

<script>
export default {
  name: 'LoginForm',
  data() {
    return {
      credentials: {
        email: '',
        password: ''
      },
      rules: {
        required: value => !!value || 'Required.',
        min: v => v.length >= 6 || 'Min 6 characters'
      },
      formValid: false
    }
  },
  methods: {
    login () {
      if (this.formValid) {
        this.$store.dispatch('AuthStore/logIn', { session: this.credentials })
          .then(() => {
            this.flash({ success: 'You have been logged in succesfully.' })
            this.$router.push({ name: 'dashboard_path' })
          })
          .catch(err => {
            if (err.response) {
              this.$refs.loginForm.reset()
              this.flash({ error: 'Invalid credentials, please try again.' })
            }
          })
      }
    }
  }
}
</script>
