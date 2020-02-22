import Vue from 'vue'
import Router from 'vue-router'

import { authenticationGuard, authorizationGuard } from '@router/guards'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/app',
      component: () => import(/* webpackChunkName: 'layout_base' */ '@views/layout/Base'),
      beforeEnter: authenticationGuard,
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
              beforeEnter: authorizationGuard
            },
            {
              path: ':employeeId',
              name: 'employee_path',
              component: () => import(/* webpackChunkName: 'employee' */ '@views/employees/Show'),
              children: [
                {
                  path: 'evaluations/:id',
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
          path: 'users',
          name: 'users_path',
          component: () => import(/* webpackChunkName: 'users' */ '@views/users/Index'),
          beforeEnter: authorizationGuard,
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
      path: '/browse/:employeeId',
      name: 'employee_browse_path',
      component: () => import(/* webpackChunkName: 'employee_browse' */ '@views/browser/Show'),
      children: [
        {
          path: 'evaluations/:id',
          name: 'evaluation_browse_path',
          component: () => import(/* webpackChunkName: 'evaluation_browse' */ '@views/browser/Evaluation')
        }
      ]
    },
    {
      path: '/',
      name: 'login_path',
      component: () => import(/* webpackChunkName: 'login' */ '@views/auth/Login'),
    },
    {
      path: '/passwords/forgot',
      name: 'forgot_password_path',
      component: () => import(/* webpackChunkName: 'forgot_password' */ '@views/auth/ForgotPassword'),
    },
    {
      path: '/passwords/reset',
      name: 'reset_password_path',
      component: () => import(/* webpackChunkName: 'reset_password' */ '@views/auth/ResetPassword'),
    },
    {
      path: '/accept_invitation',
      name: 'accept_invitation_path',
      component: () => import(/* webpackChunkName: 'accept_invitation' */ '@views/auth/SetupPassword'),
    },
    {
      path: '/errors/404',
      name: 'not_found_path',
      component: () => import(/* webpackChunkName: 'not_found' */ '@views/layout/NotFound')
    },
    {
      path: '*',
      redirect: '/errors/404'
    }
  ]
})
