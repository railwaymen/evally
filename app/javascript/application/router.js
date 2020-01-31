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
      component: () => import(/* webpackChunkName: 'layout_base' */ '@views/layout/Base'),
      beforeEnter: isAuthenticated,
      children: [
        {
          path: 'start',
          name: 'dashboard_path',
          component: () => import(/* webpackChunkName: 'dashboard' */ '@views/dashboard/Show'),
        },
        {
          path: 'drafts',
          name: 'drafts_path',
          component: () => import(/* webpackChunkName: 'drafts' */ '@views/drafts/Index'),
          children: [
            {
              path: ':id',
              name: 'draft_path',
              component: () => import(/* webpackChunkName: 'draft' */ '@views/drafts/Show'),
            }
          ]
        },
        {
          path: 'employees',
          name: 'employees_path',
          component: () => import(/* webpackChunkName: 'employees' */ '@views/employees/Index'),
          children: [
            {
              path: 'search',
              name: 'employees_search_path',
              component: () => import(/* webpackChunkName: 'employees_search' */ '@views/employees/Search'),
            },
            {
              path: 'overview',
              name: 'employees_overview_path',
              component: () => import(/* webpackChunkName: 'employees_overview' */ '@views/employees/Overview'),
            },
            {
              path: ':employeeId',
              name: 'employee_path',
              component: () => import(/* webpackChunkName: 'employee' */ '@views/employees/Show'),
              children: [
                {
                  path: 'evaluation/:id',
                  name: 'evaluation_path',
                  component: () => import(/* webpackChunkName: 'evaluation' */ '@views/employees/Evaluation')
                }
              ]
            }
          ]
        },
        {
          path: 'templates',
          name: 'templates_path',
          component: () => import(/* webpackChunkName: 'templates' */ '@views/templates/Index'),
          children: [
            {
              path: ':id',
              name: 'template_path',
              component: () => import(/* webpackChunkName: 'template' */ '@views/templates/Show'),
            }
          ]
        },
        {
          path: 'settings',
          component: () => import(/* webpackChunkName: 'settings' */ '@views/settings/Show'),
          children: [
            {
              path: 'general',
              name: 'general_settings_path',
              component: () => import(/* webpackChunkName: 'settings_general' */ '@views/settings/General'),
            },
            {
              path: 'evaluations',
              name: 'evaluations_settings_path',
              component: () => import(/* webpackChunkName: 'settings_evaluations' */ '@views/settings/Evaluations'),
            },
            {
              path: 'profile',
              name: 'profile_settings_path',
              component: () => import(/* webpackChunkName: 'settings_profile' */ '@views/settings/Profile'),
            },
            {
              path: 'support',
              name: 'support_settings_path',
              component: () => import(/* webpackChunkName: 'settings_support' */ '@views/settings/Support'),
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
      name: 'login_path',
      component: () => import(/* webpackChunkName: 'login' */ '@views/Login'),
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
