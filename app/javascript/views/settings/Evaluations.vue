<template>
  <div class="box box--with-content">
    <h1 class="box__header">{{ $t('views.settings.evaluations.title') }}</h1>

    <v-form @submit.prevent="save">
      <div class="settings pa-3">
        <h2 class="subheading my-3">{{ $t('views.settings.evaluations.defaults.subtitle') }}</h2>

        <div class="setting">
          <v-subheader>{{ $t('views.settings.evaluations.defaults.nextEvaluationOffset') }}</v-subheader>
          <v-slider
            v-model="setting.default_next_evaluation_time"
            min="1"
            max="12"
            step="1"
            thumb-label="always"
          ></v-slider>
        </div>

        <div class="settings__actions text-xs-right">
          <v-btn @click="setting.reset()" flat>
            {{ $t('shared.buttons.reset') }}
          </v-btn>

          <v-btn type="submit" class="primary" flat>
            {{ $t('shared.buttons.save') }}
          </v-btn>
        </div>
      </div>
    </v-form>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'SettingsEvaluations',
  methods: {
    save() {
      if (this.setting.validate()) {
        this.$store.dispatch('AuthStore/saveSetting', { setting: this.setting.attributes })
          .then(() => {
            this.flash({ success: this.$root.$t('settings.flashes.save_setting.success') })
          })
          .catch(error => {
            this.flash({ error: this.$root.$t('settings.flashes.save_setting.error', { reason: this.renderError(error.response) }) })
          })
      }
    }
  },
  computed: {
    ...mapGetters({
      setting: 'AuthStore/setting'
    })
  },
  created() {
    this.setting.reset()
  }
}
</script>
