<template>
  <div class="not-found">
    <div class="not-found__image">
      <img src="@assets/images/el_salvador_dali.jpg" alt="El Salvador Dali">
    </div>

    <div class="not-found__content">
      <router-link :to="{ name: 'login_path' }">
        <img class="logo" src="@assets/images/logo_black.png" alt="Logo Evally">
      </router-link>

      <h1>404</h1>
      <h2>Page not found</h2>

      <div class="homepage-link">
        <router-link :to="{ name: 'login_path' }">Go to homepage</router-link>
      </div>
    </div>
  </div>
</template>
