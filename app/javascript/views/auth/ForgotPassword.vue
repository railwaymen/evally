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

          <h3 class="auth-form__heading">Forgot Password</h3>

          <h4 class="auth-form__instruction">Enter your email to reset a password</h4>

          <div class="auth-form__group" data-cy="email">
            <v-text-field
              v-model="email"
              :rules="[vRequired]"
              prepend-inner-icon="mdi-at"
              type="email"
              label="Email"
            />
          </div>

          <div class="auth-form__actions" data-cy="submit">
            <span class="auth-form__link">
              <router-link :to="{ name: 'login_path' }">
                Back to Login
              </router-link>
            </span>

            <v-btn
              color="primary"
              type="submit"
              large
              outlined
            >
              Send
            </v-btn>
          </div>
        </v-form>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: 'ForgotPassword',
  data() {
    return {
      email: ''
    }
  },
  methods: {
    submit() {
      if (!this.$refs.form.validate()) return

      this.$store.dispatch('AuthenticationModule/forgotPassword', this.email)
        .then(this.$refs.form.reset)
    }
  }
}
</script>
