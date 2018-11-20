<template>
  <div class="box box--with-content">
    <h1 class="box__header">Evaluations settings</h1>

    <v-form>
      <div class="settings pa-3">
        <h2 class="subheading my-3">Default options</h2>

        <div class="setting">
          <v-subheader>Months to next evaluation</v-subheader>
          <v-slider
            v-model="value1"
            min="1"
            max="12"
            step="1"
            thumb-label="always"
          ></v-slider>
        </div>

        <h2 class="subheading my-3">Public view</h2>
        <div class="setting">
          <v-checkbox
            v-model="option2"
            :label="option2 ? `Enabled` : `Disabled`"
          ></v-checkbox>
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
  name: 'EvaluationsPanel',
  data() {
    return {
      value1: 6,
      option2: false
    }
  }  
}
</script>