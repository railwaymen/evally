<template>
  <div class="box box--with-content">
    <h1 class="box__header">Profile settings</h1>

    <v-layout row>
      <v-flex xs7>
        <v-form @submit.prevent="updateUser" class="pa-3">
          <v-subheader>Basic profile information</v-subheader>

          <v-layout wrap row>
            <v-flex xs12>
              <v-text-field
                v-model="user.email"
                prepend-icon="alternate_email"
                label="Email"
                disabled
              ></v-text-field>
            </v-flex>

            <v-flex xs6>
              <v-text-field
                v-model="user.first_name"
                :rules="[rules.required]"
                maxlength="32"
                label="First name"
              ></v-text-field>
            </v-flex>

            <v-flex xs6>
              <v-text-field
                v-model="user.last_name"
                :rules="[rules.required]"
                maxlength="32"
                label="Last name"
              ></v-text-field>
            </v-flex>
          </v-layout>

          <div class="settings__actions text-xs-right">
            <v-btn @click="user.reset()" flat>Reset</v-btn>
            <v-btn type="submit" class="primary" flat>Save</v-btn>
          </div>
        </v-form>
      </v-flex>

      <v-flex xs5>

      </v-flex>
    </v-layout>

    <v-divider class="my-2"></v-divider>

    <v-layout row>
      <v-flex xs7>
        <v-form ref="userPasswordForm" @submit.prevent="updatePassword" class="pa-3">
          <v-subheader>Change password form</v-subheader>

          <v-layout wrap row>
            <v-flex xs6>
              <v-text-field
                v-model="password"
                :rules="[rules.required, rules.min]"
                prepend-icon="lock"
                label="New password"
                type="password"
              ></v-text-field>
            </v-flex>

            <v-flex xs6>
              <v-text-field
                :rules="[rules.confirmed]"
                label="Password confirmation"
                type="password"
              ></v-text-field>
            </v-flex>

            <v-flex xs12>
              <v-text-field
                v-model="currentPassword"
                :rules="[rules.required, rules.min]"
                prepend-icon="lock"
                label="Old password"
                type="password"
              ></v-text-field>
            </v-flex>
          </v-layout>

          <div class="settings__actions text-xs-right">
            <v-btn @click="$refs.userPasswordForm.reset()" flat>Reset</v-btn>
            <v-btn type="submit" class="primary" flat>Change password</v-btn>
          </div>
        </v-form>
      </v-flex>

      <v-flex xs5>
        <div class="setting__info">
          <v-alert :value="true" type="warning" outline>
            You will be logged out after successful password change.
          </v-alert>
        </div>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'ProfilePanel',
  data() {
    return {
      password: '',
      currentPassword: '',
      rules: {
        required: value => !!value || 'Required',
        min: v => !!v && v.length >= 6 || 'Min 6 characters',
        confirmed: v => v === this.password || 'Both passwords must be the same'
      },
    }
  },
  methods: {
    updateUser() {
      if (this.user.validate()) {
        this.$store.dispatch('AuthStore/updateUser', { user: this.user.attributes })
          .then(() => {
            this.flash({ success: 'User has been succefully updated' })
            this.user.sync()
          })
          .catch(error => {
            this.flash({ error: 'User cannot be updated due to some error: ' + this.renderError(error.response) })
          })
      }
    },

    updatePassword() {
      if (this.$refs.userPasswordForm.validate()) {
        let params = { old_one: this.currentPassword, new_one: this.password }

        this.$store.dispatch('AuthStore/updatePassword', { password: params })
          .then(() => {
            this.flash({ success: 'Pasword has been succefully changed' })
            this.$router.push({ name: 'landing_page_path' })
          })
          .catch(error => {
            this.flash({ error: 'Password cannot be changed due to some error: ' + this.renderError(error.response) })
          })
      }
    }
  },
  computed: {
    ...mapGetters({
      user: 'AuthStore/user'
    })
  },
  beforeDestroy() {
    this.user.reset()
  }
}
</script>