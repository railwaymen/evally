<template>
  <div class="box">
    <h1 class="box__header">{{ $t('views.settings.general.title') }}</h1>

    <div v-if="loading" class="box__loader">
      <v-progress-circular :size="30" :width="3" color="primary" indeterminate></v-progress-circular>
    </div>

    <general-form v-else :setting="setting" />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

import GeneralForm from '@components/settings/GeneralForm'

export default {
  name: 'SettingsGeneral',
  components: { GeneralForm },
  methods: {
    save() {

      // if (this.setting.validate()) {
      //   this.$store.dispatch('AuthStore/saveSetting', { setting: this.setting.attributes })
      //     .then((setting) => {
      //       this.updateLocale(setting.lang || 'en')
      //       this.flash({ success: this.$root.$t('settings.flashes.save_setting.success') })
      //     })
      //     .catch(error => {
      //       this.flash({ error: this.$root.$t('settings.flashes.save_setting.error', { reason: this.renderError(error.response) }) })
      //     })
      // }
    }
  },
  computed: {
    ...mapGetters({
      setting: 'SessionModule/setting',
      loading: 'SessionModule/loading'
    })
  }
}
</script>
