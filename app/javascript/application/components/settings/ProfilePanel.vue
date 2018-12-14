<template>
  <div class="box box--with-content">
    <h1 class="box__header">{{ $t('settings.profile.title') }}</h1>

    <v-layout wrap row>
      <v-flex xs12 lg7>
        <v-form @submit.prevent="updateUser" class="pa-3">
          <h2 class="subheading my-3">{{ $t('settings.profile.basic.subheader') }}</h2>

          <v-layout wrap row>
            <v-flex xs12>
              <v-text-field
                v-model="user.email"
                prepend-icon="alternate_email"
                :label="$t('settings.profile.basic.email')"
                disabled
              ></v-text-field>
            </v-flex>

            <v-flex xs12 md6>
              <v-text-field
                v-model="user.first_name"
                :rules="[rules.required]"
                maxlength="32"
                :label="$t('settings.profile.basic.first_name')"
              ></v-text-field>
            </v-flex>

            <v-flex xs12 md6>
              <v-text-field
                v-model="user.last_name"
                :rules="[rules.required]"
                maxlength="32"
                :label="$t('settings.profile.basic.last_name')"
              ></v-text-field>
            </v-flex>
          </v-layout>

          <div class="settings__actions text-xs-right">
            <v-btn @click="user.reset()" flat>{{ $t('buttons.reset') }}</v-btn>
            <v-btn type="submit" class="primary" flat>{{ $t('buttons.save') }}</v-btn>
          </div>
        </v-form>
      </v-flex>
    </v-layout>

    <v-divider class="my-2"></v-divider>

    <v-layout wrap row>
      <v-flex xs12 lg7>
        <v-form ref="userPasswordForm" @submit.prevent="updatePassword" class="pa-3">
          <h2 class="subheading my-3">{{ $t('settings.profile.password.subheader') }}</h2>

          <v-layout wrap row>
            <v-flex xs12 md6>
              <v-text-field
                v-model="password"
                :rules="[rules.required, rules.min]"
                prepend-icon="lock"
                :label="$t('settings.profile.password.new_pass')"
                type="password"
              ></v-text-field>
            </v-flex>

            <v-flex xs12 md6>
              <v-text-field
                :rules="[rules.confirmed]"
                :label="$t('settings.profile.password.confirm_pass')"
                type="password"
              ></v-text-field>
            </v-flex>

            <v-flex xs12>
              <v-text-field
                v-model="currentPassword"
                :rules="[rules.required, rules.min]"
                prepend-icon="lock"
                :label="$t('settings.profile.password.old_pass')"
                type="password"
              ></v-text-field>
            </v-flex>
          </v-layout>

          <div class="settings__actions text-xs-right">
            <v-btn @click="$refs.userPasswordForm.reset()" flat>{{ $t('buttons.reset') }}</v-btn>
            <v-btn type="submit" class="primary" flat>{{ $t('buttons.change_pass') }}</v-btn>
          </div>
        </v-form>
      </v-flex>

      <v-flex xs12 lg5>
        <div class="setting__info">
          <v-alert :value="true" type="warning" outline>
            {{ $t('settings.profile.password.warning') }}
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
            this.flash({ success: this.$t('settings.flashes.update_user.success') })
            this.user.sync()
          })
          .catch(error => {
            this.flash({ error: this.$t('settings.flashes.update_user.error', { reason: this.renderError(error.response) }) })
          })
      }
    },

    updatePassword() {
      if (this.$refs.userPasswordForm.validate()) {
        let params = { old_one: this.currentPassword, new_one: this.password }

        this.$store.dispatch('AuthStore/updatePassword', { password: params })
          .then(() => {
            this.flash({ success: this.$t('settings.flashes.update_pass.success') })
            this.$router.push({ name: 'landing_page_path' })
          })
          .catch(error => {
            this.flash({ error: this.$t('settings.flashes.update_pass.error', { reason: this.renderError(error.response) }) })
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