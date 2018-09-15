<template>
  <div class="landing__form">
    <h3 class="secondary-heading secondary-heading--light margin-bottom-20">sign up</h3>

    <v-form ref="form" v-model="formValid" @submit.prevent="print">

      <div class="landing__form-group">
        <v-text-field
          v-model="account.email"
          prepend-icon="alternate_email"
          type="email"
          label="email"
          dark
        ></v-text-field>

        <v-layout row>
          <v-flex xs6>
            <v-text-field
              v-model="account.password"
              prepend-icon="lock"
              type="password"
              label="password"
              dark
            ></v-text-field>
          </v-flex>
          <span class="separator"></span>
          <v-flex xs6>
            <v-text-field
              type="password"
              label="confirm password"
              dark
            ></v-text-field>
          </v-flex>
        </v-layout>

        <v-layout row>
          <v-flex xs6>
            <v-text-field
              v-model="account.firstName"
              prepend-icon="perm_identity"
              type="text"
              label="first name"
              dark
            ></v-text-field>
          </v-flex>
          <span class="separator"></span>
          <v-flex xs6>
            <v-text-field
              v-model="account.lastName"
              type="text"
              label="last name"
              dark
            ></v-text-field>
          </v-flex>
        </v-layout>

        <v-checkbox
          v-model="account.rememberMe"
          label="I accept terms of use"
          color="white"
          dark
        ></v-checkbox>
        <v-text-field
          v-model="account.appPassword"
          prepend-icon="fingerprint"
          type="password"
          label="admin password"
          dark
        ></v-text-field>
      </div>

      <div class="landing__form-action margin-top-20">
        <v-btn color="white" type="submit" flat outline round block>Sign up</v-btn>
      </div>

      <div class="landing__form-question">
        <p>
          Already have account?
          <span class="primary--text" @click="openLoginForm">Log in</span>
        </p>
      </div>
    </v-form>
  </div>
</template>

<script>
export default {
  name: 'RegisterForm',
  data() {
    return {
      account: {
        firstName: '',
        lastName: '',
        email: '',
        password: '',
        appPassword: ''
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
    openLoginForm() {
      this.$emit('toggle', 'login')
    },
    print: () => {
      console.log('Form sent!')
    }
  }
}
</script>
