<template>
  <div class="box box--with-content">
    <h1 class="box__header">General settings</h1>

    <v-form>
      <div class="settings pa-3">
        <h2 class="subheading my-3">Dashboard widgets</h2>
      
        <div class="setting">
          <v-subheader>Number of draft items</v-subheader>
          <v-slider
            v-model="value1"
            min="3"
            max="12"
            step="1"
            thumb-label="always"
          ></v-slider>
        </div>

        <div class="setting">
          <v-subheader>Number of upcoming items</v-subheader>
          <v-slider
            v-model="value2"
            min="3"
            max="12"
            step="1"
            thumb-label="always"
          ></v-slider>
        </div>

        <div class="settings__actions text-xs-right">
          <v-btn flat>Reset</v-btn>
          <v-btn class="primary" flat>Save</v-btn>
        </div>
      </div>
    </v-form>
  </div>
</template>

<script>
export default {
  name: 'GeneralPanel',
  data() {
    return {
      value1: 5,
      value2: 6
    }
  }  
}
</script>