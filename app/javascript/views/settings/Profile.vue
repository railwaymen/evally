<template>
  <div class="box">
    <h1 class="box__header">{{ $t('views.settings.profile.title') }}</h1>

    <v-layout wrap row>
      <v-flex xs12 lg7>
        <v-form @submit.prevent="updateUser" class="pa-3">
          <h2 class="subheading my-3">{{ $t('views.settings.profile.basic.subtitle') }}</h2>

          <v-layout wrap row>
            <v-flex xs12>
              <v-text-field
                v-model="user.email"
                prepend-icon="alternate_email"
                :label="$t('views.settings.profile.basic.email')"
                disabled
              />
            </v-flex>

            <v-flex xs12 md6>
              <v-text-field
                v-model="user.first_name"
                :rules="[vRequired]"
                maxlength="32"
                :label="$t('views.settings.profile.basic.firstName')"
              />
            </v-flex>

            <v-flex xs12 md6>
              <v-text-field
                v-model="user.last_name"
                :rules="[vRequired]"
                maxlength="32"
                :label="$t('views.settings.profile.basic.lastName')"
              />
            </v-flex>
          </v-layout>

          <div class="settings__actions text-xs-right">
            <v-btn @click="user.reset()" flat>
              {{ $t('shared.buttons.reset') }}
            </v-btn>

            <v-btn type="submit" class="primary" flat>
              {{ $t('shared.buttons.save') }}
            </v-btn>
          </div>
        </v-form>
      </v-flex>
    </v-layout>

    <v-divider class="my-2"></v-divider>

    <v-layout wrap row>
      <v-flex xs12 lg7>
        <v-form ref="userPasswordForm" @submit.prevent="updatePassword" class="pa-3">
          <h2 class="subheading my-3">{{ $t('views.settings.profile.password.subtitle') }}</h2>

          <v-layout wrap row>
            <v-flex xs12 md6>
              <v-text-field
                v-model="password"
                :rules="[vRequired, vMin6]"
                prepend-icon="lock"
                :label="$t('views.settings.profile.password.newPassword')"
                type="password"
              />
            </v-flex>

            <v-flex xs12 md6>
              <v-text-field
                :rules="[vConfirmed, vMin6]"
                :label="$t('views.settings.profile.password.confirmPassword')"
                type="password"
              />
            </v-flex>

            <v-flex xs12>
              <v-text-field
                v-model="currentPassword"
                :rules="[vRequired, vMin6]"
                prepend-icon="lock"
                :label="$t('views.settings.profile.password.oldPassword')"
                type="password"
              ></v-text-field>
            </v-flex>
          </v-layout>

          <div class="settings__actions text-xs-right">
            <v-btn @click="$refs.userPasswordForm.reset()" flat>
              {{ $t('shared.buttons.reset') }}
            </v-btn>

            <v-btn type="submit" class="primary" flat>
              {{ $t('shared.buttons.changePassword') }}
            </v-btn>
          </div>
        </v-form>
      </v-flex>

      <v-flex xs12 lg5>
        <div class="setting__info">
          <v-alert :value="true" type="warning" outline>
            {{ $t('views.settings.profile.password.warning') }}
          </v-alert>
        </div>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'SettingsProfile',
  data() {
    return {
      password: '',
      currentPassword: ''
    }
  },
  methods: {
    updateUser() {
      if (this.user.validate()) {
        this.$store.dispatch('AuthStore/updateUser', { user: this.user.attributes })
          .then(() => {
            this.flash({ success: this.$root.$t('settings.flashes.update_user.success') })
            this.user.sync()
          })
          .catch(error => {
            this.flash({ error: this.$root.$t('settings.flashes.update_user.error', { reason: this.renderError(error.response) }) })
          })
      }
    },

    updatePassword() {
      if (this.$refs.userPasswordForm.validate()) {
        let params = { old_one: this.currentPassword, new_one: this.password }

        this.$store.dispatch('AuthStore/updatePassword', { password: params })
          .then(() => {
            this.flash({ success: this.$root.$t('settings.flashes.update_pass.success') })
            this.$router.push({ name: 'login_path' })
          })
          .catch(error => {
            this.flash({ error: this.$root.$t('settings.flashes.update_pass.error', { reason: this.renderError(error.response) }) })
          })
      }
    },

    vConfirmed(val) {
      return val === this.password || this.$t('shared.validations.confirmed')
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
