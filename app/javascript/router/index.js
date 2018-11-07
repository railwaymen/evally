import Vue from 'vue'
import Router from 'vue-router'

import store from '../store'

Vue.use(Router)


const isAuthenticated = (to, from, next) => {
  if (store.getters['AuthStore/isAuthenticated']) {
    next()
  } else {
    store.commit('FlashStore/push', { error: 'You are not authorized to perform this action. Please log in.' })
    next('/')
  }
}


export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/app',
      component: require('../components/Layout').default,
      beforeEnter: isAuthenticated,
      children: [
        {
          path: '/',
          name: 'dashboard_path',
          component: require('../components/app/DashboardPage').default,
        },
        {
          path: 'evaluations',
          name: 'evaluations_path',
          component: require('../components/app/EvaluationsPage').default,
        },
        {
          path: 'employees',
          name: 'employees_path',
          component: require('../components/app/EmployeesPage').default,
        },
        {
          path: 'templates',
          name: 'templates_path',
          component: require('../components/app/TemplatesPage').default,
        },
        {
          path: 'archive',
          name: 'archive_path',
          component: require('../components/app/ArchivePage').default,
        },
        {
          path: 'settings',
          name: 'settings_path',
          component: require('../components/app/SettingsPage').default,
        },
        {
          path: 'profile',
          name: 'profile_path',
          component: require('../components/app/ProfilePage').default,
        }
      ]
    },
    {
      path: '/browse/:id',
      name: 'browse_page_path',
      component: require('../components/app/PublicEvaluationPage').default
    },
    {
      path: '/',
      name: 'landing_page_path',
      component: require('../components/LandingPage').default,
    },
    {
      path: '/not_found',
      name: 'not_found_path',
      component: require('../components/404').default,
    },
    {
      path: '*',
      redirect: '/not_found'
    }
  ]
})
