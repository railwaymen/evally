<template>
  <div class="box box--with-content">
    <h1 class="box__header">Evaluations settings</h1>

    <v-form @submit.prevent="save">
      <div class="settings pa-3">
        <h2 class="subheading my-3">Default options</h2>

        <div class="setting">
          <v-subheader>Months to next evaluation</v-subheader>
          <v-slider
            v-model="setting.default_next_evaluation_time"
            min="1"
            max="12"
            step="1"
            thumb-label="always"
          ></v-slider>
        </div>

        <h2 class="subheading my-3">Public view</h2>
        <div class="setting">
          <v-checkbox
            v-model="setting.public_view_enabled"
            label="Enable public view"
          ></v-checkbox>
        </div>

        <div class="settings__actions text-xs-right">
          <v-btn @click="setting.reset()" flat>Reset</v-btn>
          <v-btn type="submit" class="primary" flat>Save</v-btn>
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
            this.flash({ success: 'Settings has been succefully updated' })
          })
          .catch(error => {
            this.flash({ error: 'Settings cannot be updated due to some error: ' + this.renderError(error.response) })
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