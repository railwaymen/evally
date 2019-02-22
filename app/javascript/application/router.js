import Vue from 'vue'
import Router from 'vue-router'

import store from '@/store'

Vue.use(Router)


const isAuthenticated = (to, from, next) => {
  if (localStorage.getItem('ev411y_t0k3n')) {
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
          path: 'start',
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
          component: require('@/components/pages/Archive').default,
          children: [
            {
              path: 'employees',
              name: 'employees_archive_path',
              component: require('@/components/employees/EmployeeEvaluationBox').default,
            },
            {
              path: 'activities',
              name: 'activities_archive_path',
              component: require('@/components/archive/ActivitiesTimelineBox').default,
            },
          ]
        },
        {
          path: 'overview',
          name: 'overview_path',
          component: require('@/components/pages/Overview').default,
        },
        {
          path: 'settings',
          component: require('@/components/pages/Settings').default,
          children: [
            {
              path: 'general',
              name: 'general_settings_path',
              component: require('@/components/settings/GeneralPanel').default,
            },
            {
              path: 'evaluations',
              name: 'evaluations_settings_path',
              component: require('@/components/settings/EvaluationsPanel').default,
            },
            {
              path: 'profile',
              name: 'profile_settings_path',
              component: require('@/components/settings/ProfilePanel').default,
            },
            {
              path: 'support',
              name: 'support_path',
              component: require('@/components/settings/SupportPanel').default,
            }
          ]
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
