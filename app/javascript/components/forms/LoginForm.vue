<template>
  <div class="landing__form">
    <h3 class="secondary-heading secondary-heading--dark mb-4">sign in</h3>

    <v-form ref="loginForm" v-model="formValid" @submit.prevent="login">

      <div class="landing__form-group">
        <v-text-field
          v-model="credentials.email"
          prepend-icon="alternate_email"
          label="email"
        ></v-text-field>
        <v-text-field
          v-model="credentials.password"
          prepend-icon="lock"
          type="password"
          label="password"
        ></v-text-field>
        <v-checkbox
          label="remember me"
          color="primary"
        ></v-checkbox>
      </div>

      <div class="landing__form-action mt-4">
        <v-btn color="primary" type="submit" flat outline round block>Sign in</v-btn>
      </div>

      <div class="landing__form-question">
        <p>
          No account?
          <span class="primary--text" @click="openRegisterForm">Sign up</span>
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
        email: 'john.doe@example.com',
        password: '1234qwer'
      },
      rules: {
        required: value => !!value || 'Required.',
        min: v => v.length >= 6 || 'Min 6 characters'
      },
      formValid: false,
      passVisible: false
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
    },
    openRegisterForm () {
      this.$emit('toggle', 'register')
    }
  }
}
</script>
