<template>
  <div class="box box--with-content">
    <h1 class="box__header">{{ $t('settings.evaluations.title') }}</h1>

    <v-form @submit.prevent="save">
      <div class="settings pa-3">
        <h2 class="subheading my-3">{{ $t('settings.evaluations.defaults.subheader') }}</h2>

        <div class="setting">
          <v-subheader>{{ $t('settings.evaluations.defaults.next_review_offset') }}</v-subheader>
          <v-slider
            v-model="setting.default_next_evaluation_time"
            min="1"
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
  name: 'EvaluationsPanel',
  methods: {
    save() {
      if (this.setting.validate()) {
        this.$store.dispatch('AuthStore/saveSetting', { setting: this.setting.attributes })
          .then(() => {
            this.flash({ success: this.$t('settings.flashes.save_setting.success') })
          })
          .catch(error => {
            this.flash({ error: this.$t('settings.flashes.save_setting.error', { reason: this.renderError(error.response) }) })
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