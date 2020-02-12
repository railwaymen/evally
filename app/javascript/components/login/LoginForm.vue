<template>
  <div class="login-form elevation-2">
    <div class="login-form__logo" data-cy="evally_logo">
      <img src="@assets/images/logo_black.png" alt="Logo Evally">
    </div>

    <h3 class="login-form__heading login-form__heading--dark mb-4">Sign in</h3>

    <v-form ref="loginForm" @submit.prevent="submit">
      <div class="login-form__group" data-cy="email">
        <v-text-field
          v-model="credentials.email"
          prepend-icon="alternate_email"
          type="email"
          label="Email"
        />
      </div>
      <div class="login-form__group" data-cy="password">
        <v-text-field
          v-model="credentials.password"
          prepend-icon="lock"
          type="password"
          label="Password"
        />
      </div>

      <div class="login-form__action mt-4" data-cy="submit">
        <v-btn
          color="primary"
          type="submit"
          outlined
          rounded
          block
          text
        >
          Sign in
        </v-btn>
      </div>
    </v-form>
  </div>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  name: 'LoginForm',
  data() {
    return {
      credentials: {
        email: '',
        password: ''
      }
    }
  },
  methods: {
    submit() {
      this.createSession(this.credentials)
        .then(() => this.$router.push({ name: 'dashboard_path' }))
        .catch(() => this.flash({ error: 'Invalid credentials, please try again.' }))
    },
    ...mapActions({
      createSession: 'SessionModule/create'
    })
  }
}
</script>
