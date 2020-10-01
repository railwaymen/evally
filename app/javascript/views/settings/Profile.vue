<template>
  <div class="box">
    <h1 class="box__header">{{ $t('views.settings.profile.title') }}</h1>

    <v-layout wrap row>
      <v-flex xs12>
        <div v-if="loading" class="box__loader">
          <v-progress-circular :size="30" :width="3" color="primary" indeterminate />
        </div>

        <user-form v-else :user="user" />
      </v-flex>
    </v-layout>

    <v-divider class="my-2" />

    <v-layout wrap row>
      <v-flex xs12 lg7>
        <password-form />
      </v-flex>

      <v-flex xs12 lg5>
        <div class="setting__info">
          <v-alert type="warning" outlined>
            {{ $t('views.settings.profile.logOutWarning') }}
          </v-alert>
        </div>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapState } from 'vuex'

import PasswordForm from '@components/settings/PasswordForm'
import UserForm from '@components/settings/UserForm'

export default {
  name: 'SettingsProfile',
  components: { PasswordForm, UserForm },
  computed: {
    ...mapState('AuthenticationModule', [
      'user',
      'loading'
    ])
  }
}
</script>
