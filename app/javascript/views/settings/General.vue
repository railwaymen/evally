<template>
  <div class="box">
    <h1 class="box__header">{{ $t('views.settings.general.title') }}</h1>

    <div v-if="loading" class="box__loader">
      <v-progress-circular :size="30" :width="3" color="primary" indeterminate />
    </div>

    <general-form v-else :setting="setting" />
  </div>
</template>

<script>
import { mapState } from 'vuex'

import GeneralForm from '@components/settings/GeneralForm'

export default {
  name: 'SettingsGeneral',
  components: { GeneralForm },
  computed: {
    ...mapState('AuthenticationModule', [
      'setting',
      'loading'
    ])
  }
}
</script>
