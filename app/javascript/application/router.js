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
      component: () => import(/* webpackChunkName: 'layout_base' */ '@views/Base'),
      beforeEnter: isAuthenticated,
      children: [
        {
          path: 'start',
          name: 'dashboard_path',
          component: () => import(/* webpackChunkName: 'dashboard' */ '@views/Dashboard'),
        },
        {
          path: 'drafts',
          name: 'drafts_path',
          component: () => import(/* webpackChunkName: 'drafts' */ '@views/Drafts'),
          children: [
            {
              path: ':id',
              name: 'draft_path',
              component: () => import(/* webpackChunkName: 'draft' */ '@views/Draft'),
            }
          ]
        },
        {
          path: 'employees',
          name: 'employees_path',
          component: () => import(/* webpackChunkName: 'employees' */ '@views/Employees'),
          children: [
            {
              path: 'search',
              name: 'employees_search_path',
              component: () => import(/* webpackChunkName: 'employees_search' */ '@views/EmployeesSearch'),
            },
            {
              path: 'overview',
              name: 'employees_overview_path',
              component: () => import(/* webpackChunkName: 'employees_overview' */ '@views/EmployeesOverview'),
            },
            {
              path: ':employeeId',
              name: 'employee_path',
              component: () => import(/* webpackChunkName: 'employee' */ '@views/Employee'),
              children: [
                {
                  path: 'evaluation/:id',
                  name: 'employee_evaluation_path',
                  component: () => import(/* webpackChunkName: 'employee_evaluation' */ '@views/Evaluation')
                }
              ]
            }
          ]
        },
        {
          path: 'templates',
          name: 'templates_path',
          component: () => import(/* webpackChunkName: 'templates' */ '@views/Templates'),
          children: [
            {
              path: ':id',
              name: 'template_path',
              component: () => import(/* webpackChunkName: 'template' */ '@views/Template'),
            }
          ]
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
