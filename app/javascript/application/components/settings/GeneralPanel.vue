<template>
  <div class="box box--with-content">
    <h1 class="box__header">General settings</h1>

    <v-form>
      <div class="settings pa-3">
        <h2 class="subheading my-3">Dashboard widgets</h2>

        <div class="setting">
          <v-subheader>Number of draft items</v-subheader>
          <v-slider
            v-model="setting.default_draft_items"
            min="3"
            max="12"
            step="1"
            thumb-label="always"
          ></v-slider>
        </div>

        <div class="setting">
          <v-subheader>Number of upcoming items</v-subheader>
          <v-slider
            v-model="setting.default_upcoming_items"
            min="3"
            max="12"
            step="1"
            thumb-label="always"
          ></v-slider>
        </div>

        <div class="settings__actions text-xs-right">
          <v-btn @click="setting.reset()" flat>Reset</v-btn>
          <v-btn @click="save" class="primary" flat>Save</v-btn>
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
  }
}
</script>