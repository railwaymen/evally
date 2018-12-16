<template>
  <div class="box box--with-content">
    <h1 class="box__header">{{ $t('settings.general.title') }}</h1>

    <v-form @submit.prevent="save">
      <div class="settings pa-3">

        <h2 class="subheading my-3">{{ $t('settings.general.language.subheader') }}</h2>

        <div class="setting">
          <v-radio-group v-model="setting.lang" row>
            <v-radio :label="$t('settings.general.language.polish')" value="pl"></v-radio>
            <v-radio :label="$t('settings.general.language.english')" value="en"></v-radio>
          </v-radio-group>
        </div>

        <h2 class="subheading my-3">{{ $t('settings.general.widgets.subheader') }}</h2>

        <div class="setting">
          <v-subheader>{{ $t('settings.general.widgets.draft_items') }}</v-subheader>
          <v-slider
            v-model="setting.default_draft_items"
            min="3"
            max="12"
            step="1"
            thumb-label="always"
          ></v-slider>
        </div>

        <div class="setting">
          <v-subheader>{{ $t('settings.general.widgets.upcoming_items') }}</v-subheader>
          <v-slider
            v-model="setting.default_upcoming_items"
            min="3"
            max="12"
            step="1"
            thumb-label="always"
          ></v-slider>
        </div>

        <div class="settings__actions text-xs-right">
          <v-btn @click="setting.reset()" flat>{{ $t('buttons.reset') }}</v-btn>
          <v-btn type="submit" class="primary" flat>{{ $t('buttons.save') }}</v-btn>
        </div>
      </div>
    </v-form>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'GeneralPanel',
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