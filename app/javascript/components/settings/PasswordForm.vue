<template>
  <v-form ref="form" @submit.prevent="updatePassword" class="pa-3">
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
        />
      </v-flex>
    </v-layout>

    <div class="settings__actions text-xs-right">
      <v-btn @click="$refs.form.reset()" flat>
        {{ $t('shared.buttons.reset') }}
      </v-btn>

      <v-btn type="submit" class="primary" flat>
        {{ $t('shared.buttons.changePassword') }}
      </v-btn>
    </div>
  </v-form>
</template>

<script>
export default {
  name: 'PasswordForm',
  data() {
    return {
      password: '',
      currentPassword: ''
    }
  },
  methods: {
    vConfirmed(val) {
      return val === this.password || this.$t('shared.validations.confirmed')
    }
  }
}
</script>
