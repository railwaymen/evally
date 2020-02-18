<template>
  <section class="auth-page">
    <div class="auth-page__content">
      <div class="auth-page__side elevation-1">
        <v-form
          ref="form"
          @submit.prevent="submit"
          class="auth-form"
        >
          <div class="auth-form__logo">
            <img src="@assets/images/logo_black.png" alt="Logo Evally">
          </div>

          <h3 class="auth-form__heading">Sign In</h3>

          <div class="auth-form__group" data-cy="login-email">
            <v-text-field
              v-model="credentials.email"
              :rules="[vRequired]"
              prepend-inner-icon="mdi-at"
              type="email"
              label="Email"
            />
          </div>

          <div class="auth-form__group" data-cy="login-password">
            <v-text-field
              v-model="credentials.password"
              :rules="[vRequired]"
              prepend-inner-icon="mdi-lock-outline"
              type="password"
              label="Password"
            />
          </div>

          <div class="auth-form__actions" data-cy="login-submit">
            <span class="auth-form__link">
              <router-link :to="{ name: 'remind_password_path' }">
                Forgot your password?
              </router-link>
            </span>

            <v-btn
              color="primary"
              type="submit"
              large
              outlined
            >
              Sign in
            </v-btn>
          </div>
        </v-form>
      </div>
    </div>
  </section>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  name: 'Login',
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
      if (this.$refs.form.validate()) {
        this.createSession(this.credentials)
          .then(() => this.$router.push({ name: 'dashboard_path' }))
          .catch(() => this.flash({ error: 'Invalid credentials, please try again.' }))
      }
    },
    ...mapActions({
      createSession: 'SessionModule/create'
    })
  },
  created () {
    if (localStorage.getItem('ev411y_t0k3n')) {
      this.$router.push({ name: 'dashboard_path' })
    }
  }
}
</script>
