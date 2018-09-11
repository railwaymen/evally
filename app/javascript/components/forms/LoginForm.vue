<template>
  <div class="landing__form">
    <h3 class="heading-secondary heading-secondary--dark margin-bottom-20">sign in</h3>

    <v-form ref="form" v-model="formValid" @submit.prevent="print">

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
          v-model="credentials.rememberMe"
          label="remember me"
          color="primary"
        ></v-checkbox>
      </div>

      <div class="landing__form-action margin-top-20">
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
  data() {
    return {
      credentials: {
        email: '',
        password: '',
        rememberMe: false
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
    openRegisterForm() {
      this.$emit('toggle', 'register')
    },
    print: () => {
      console.log('Form sent!')
    }
  }
}
</script>
