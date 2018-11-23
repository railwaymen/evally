<template>
  <div class="box box--with-content">
    <h1 class="box__header">Profile settings</h1>

    <v-layout row>
      <v-flex xs7>
        <v-form class="pa-3">
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
                label="First name"
              ></v-text-field>
            </v-flex>

            <v-flex xs6>
              <v-text-field
                v-model="user.last_name"
                :rules="[rules.required]"
                label="Last name"
              ></v-text-field>
            </v-flex>

            <v-flex xs12>
              <v-text-field
                v-model="user.position"
                label="Position"
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
        <div class="setting__info">
          <v-alert :value="true" type="info" outline>
            This information will appear on your profile.
          </v-alert>
        </div>
      </v-flex>
    </v-layout>

    <v-divider class="my-2"></v-divider>

    <v-layout row>
      <v-flex xs7>
        <v-form ref="userPasswordForm" class="pa-3">
          <v-subheader>Change password form</v-subheader>

          <v-layout wrap row>
            <v-flex xs6>
              <v-text-field
                :rules="[rules.required, rules.min]"
                prepend-icon="lock"
                label="New password"
                type="password"
              ></v-text-field>
            </v-flex>

            <v-flex xs6>
              <v-text-field
                :rules="[rules.required, rules.min, rules.confirmed]"
                label="Password confirmation"
                type="password"
              ></v-text-field>
            </v-flex>

            <v-flex xs12>
              <v-text-field
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
      rules: {
        required: value => !!value || 'Required',
        min: v => v.length >= 6 || 'Min 6 characters',
        confirmed: v => v === this.password || 'Both passwords must be the same'
      },
    }
  },
  computed: {
    ...mapGetters({
      user: 'AuthStore/user'
    })
  }
}
</script>