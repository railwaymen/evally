import Vue from 'vue'
import Router from 'vue-router'

import store from '@/store'

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
      component: require('@/components/shared/Layout').default,
      beforeEnter: isAuthenticated,
      children: [
        {
          path: '/',
          name: 'dashboard_path',
          component: require('@/components/pages/Dashboard').default,
        },
        {
          path: 'evaluations',
          name: 'evaluations_path',
          component: require('@/components/pages/Evaluations').default,
        },
        {
          path: 'employees',
          name: 'employees_path',
          component: require('@/components/pages/Employees').default,
        },
        {
          path: 'templates',
          name: 'templates_path',
          component: require('@/components/pages/Templates').default,
        },
        {
          path: 'archive',
          name: 'archive_path',
          component: require('@/components/pages/Archive').default,
        },
        {
          path: 'settings',
          component: require('@/components/pages/Settings').default,
          children: [
            {
              path: '',
              name: 'general_settings_path',
              component: require('@/components/settings/GeneralPanel').default,
            },
            {
              path: 'evaluations',
              name: 'evaluations_settings_path',
              component: require('@/components/settings/EvaluationsPanel').default,
            }
          ]
        },
        {
          path: 'profile',
          name: 'profile_path',
          component: require('@/components/pages/Profile').default,
        }
      ]
    },
    {
      path: '/browse/:id',
      name: 'browse_page_path',
      component: require('@/components/pages/PublicEvaluation').default
    },
    {
      path: '/',
      name: 'landing_page_path',
      component: require('@/components/pages/Landing').default,
    },
    {
      path: '/not_found',
      name: 'not_found_path',
      component: require('@/components/pages/404').default,
    },
    {
      path: '*',
      redirect: '/not_found'
    }
  ]
})
