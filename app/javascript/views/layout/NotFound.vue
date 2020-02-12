<template>
  <div class="error-page">
    <div class="error-page__content">
      <img class="error-page__logo" src="@assets/images/logo_black.png" />

      <h1 class="error-page__header">Oops!</h1>
      <h2 class="error-page__subheader">404 - The Page Can't Be Found</h2>
    </div>

    <v-btn
      :to="{ name: 'dashboard_path' }"
      class="ma-2"
      text
    >
      Go To Homepage
    </v-btn>
  </div>
</template>

<script>
export default {
  name: 'NotFound'
}
</script>
