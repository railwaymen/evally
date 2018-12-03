<template>
  <section class="public-section">
    <div class="public-section__bg"></div>

    <div class="public-section__content">
      <login-form></login-form>
    </div>
  </section>
</template>

<script>
import LoginForm from '@/components/landing/LoginForm'

export default {
  name: 'Landing',
  components: { LoginForm },
  created () {
    if (localStorage.getItem('ev411y_t0k3n')) {
      this.$router.push({ name: 'dashboard_path' })
    }
  }
}
</script>
