<template>
  <section class="landing-section">
    <login-form></login-form>
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
