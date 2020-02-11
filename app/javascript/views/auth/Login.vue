<template>
  <section class="main">
    <div class="main__bg" />

    <div class="main__content">
      <login-form />
    </div>
  </section>
</template>

<script>
import LoginForm from '@components/login/LoginForm'

export default {
  name: 'Login',
  components: { LoginForm },
  created () {
    if (localStorage.getItem('ev411y_t0k3n')) {
      this.$router.push({ name: 'dashboard_path' })
    }
  }
}
</script>
