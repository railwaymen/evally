<template>
  <div class="box">
    <h1 class="box__header">{{ $t('views.settings.general.title') }}</h1>

    <v-form @submit.prevent="save">
      <div class="settings pa-3">
        <h2 class="subheading my-3">{{ $t('views.settings.general.language.subtitle') }}</h2>

        <div class="setting">
          <v-radio-group v-model="setting.lang" row>
            <v-radio :label="$t('views.settings.general.language.polish')" value="pl" />
            <v-radio :label="$t('views.settings.general.language.english')" value="en" />
          </v-radio-group>
        </div>

        <h2 class="subheading my-3">{{ $t('views.settings.general.widgets.subtitle') }}</h2>

        <div class="setting">
          <v-subheader>{{ $t('views.settings.general.widgets.drafts') }}</v-subheader>
          <v-slider
            v-model="setting.default_draft_items"
            min="3"
            max="12"
            step="1"
            thumb-label="always"
          />
        </div>

        <div class="setting">
          <v-subheader>{{ $t('views.settings.general.widgets.upcoming') }}</v-subheader>
          <v-slider
            v-model="setting.default_upcoming_items"
            min="3"
            max="12"
            step="1"
            thumb-label="always"
          />
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
  name: 'SettingsGeneral',
  methods: {
    save() {
      if (this.setting.validate()) {
        this.$store.dispatch('AuthStore/saveSetting', { setting: this.setting.attributes })
          .then((setting) => {
            this.updateLocale(setting.lang || 'en')
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
