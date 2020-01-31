<template>
  <div class="box">
    <h1 class="box__header">{{ $t('views.settings.support.title') }}</h1>

    <v-form>
      <div class="settings pa-3">
        <h2 class="subheading my-3">{{ $t('views.settings.support.text') }}</h2>
      </div>
    </v-form>
  </div>
</template>

<script>
export default {
  name: 'SettingsSupport'
}
</script>
