import Vue from 'vue'
import Router from 'vue-router'

import LandingPage from '../components/LandingPage'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'landing_page',
      component: LandingPage
    },
    {
      path: '*',
      redirect: '/'
    }
  ]
})
