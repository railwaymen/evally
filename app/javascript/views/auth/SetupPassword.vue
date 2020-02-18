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

          <h3 class="auth-form__heading">Setup Password</h3>

          <h4 class="auth-form__instruction">Please enter twice the password you would like to use for authentication</h4>

          <div class="auth-form__group">
            <v-text-field
              v-model="password"
              :rules="[vRequired]"
              prepend-inner-icon="mdi-lock-outline"
              type="password"
              label="Password"
            />
          </div>

          <div class="auth-form__group">
            <v-text-field
              v-model="password"
              :rules="[vRequired]"
              prepend-inner-icon="mdi-lock-outline"
              type="password"
              label="Password Confirmation"
            />
          </div>

          <div class="auth-form__actions" data-cy="submit">
            <v-spacer />

            <v-btn
              color="primary"
              type="submit"
              large
              outlined
            >
              Setup
            </v-btn>
          </div>
        </v-form>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: 'RemindPassword',
  data() {
    return {
      password: '',
      passwordConfirmation: ''
    }
  },
  methods: {
    submit() {
      if (this.$refs.form.validate()) {
        console.log('Submit!')
      }
    }
  },
  created () {
    if (localStorage.getItem('ev411y_t0k3n')) {
      this.$router.push({ name: 'dashboard_path' })
    }
  }
}
</script>
