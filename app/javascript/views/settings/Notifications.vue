<template>
  <div class="box">
    <h1 class="box__header">{{ $t('views.settings.notifications.title') }}</h1>

    <div v-if="loading" class="box__loader">
      <v-progress-circular :size="30" :width="3" color="primary" indeterminate />
    </div>

    <notifications-form v-else :setting="setting" />
  </div>
</template>

<script>
import { mapState } from 'vuex'

import NotificationsForm from '@components/settings/NotificationsForm'

export default {
  name: 'SettingsGeneral',
  components: { NotificationsForm },
  computed: {
    ...mapState('AuthenticationModule', [
      'setting',
      'loading'
    ])
  }
}
</script>
