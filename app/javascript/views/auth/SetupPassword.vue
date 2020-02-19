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
              v-model="invitation.password"
              :rules="[vRequired, vMin6]"
              prepend-inner-icon="mdi-lock-outline"
              type="password"
              label="Password"
            />
          </div>

          <div class="auth-form__group">
            <v-text-field
              v-model="invitation.password_confirmation"
              :rules="[vRequired, vConfirmed]"
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
      invitation: {
        password: '',
        password_confirmation: ''
      }
    }
  },
  methods: {
    submit() {
      if (!this.$refs.form.validate()) return

      const params = {
        invitationToken: new URLSearchParams(window.location.search).get('invitation_token'),
        invitation: this.invitation
      }

      this.$store.dispatch('AuthenticationModule/acceptInvitation', params)
        .then(() => this.$router.push({ name: 'login_path' }))
    },
    vConfirmed(val) {
      return val === this.invitation.password || this.$t('shared.validations.confirmed')
    }
  },
  created () {
    if (localStorage.getItem('ev411y_t0k3n')) {
      this.$router.push({ name: 'dashboard_path' })
    }
  }
}
</script>
