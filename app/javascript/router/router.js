import Vue from 'vue'
import Router from 'vue-router'

import {
  alreadyAuthenticatedGuard,
  authenticationGuard,
  adminAuthorizedGuard,
  recruiterAuthorizedGuard
} from '@router/guards'

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
          path: 'evaluations',
          name: 'evaluation_drafts_path',
          component: () => import(/* webpackChunkName: 'evaluations' */ '@views/evaluations/Index'),
          children: [
            {
              path: ':id',
              name: 'evaluation_draft_path',
              component: () => import(/* webpackChunkName: 'evaluation' */ '@views/evaluations/Show'),
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
              beforeEnter: adminAuthorizedGuard
            },
            {
              path: 'archived',
              name: 'employees_archived_path',
              component: () => import(/* webpackChunkName: 'employees_archived' */ '@views/employees/Archived'),
              beforeEnter: adminAuthorizedGuard
            },
            {
              path: ':employeeId',
              name: 'employee_path',
              component: () => import(/* webpackChunkName: 'employee' */ '@views/employees/Show'),
              children: [
                {
                  path: 'evaluations/:id',
                  name: 'evaluation_completed_path',
                  component: () => import(/* webpackChunkName: 'evaluation' */ '@views/employees/Evaluation')
                }
              ]
            }
          ]
        },
        {
          path: 'notifications',
          name: 'notifications_path',
          component: () => import(/* webpackChunkName: 'notifications' */ '@views/notifications/Index'),
        },
        {
          path: 'recruitments',
          name: 'recruitments_path',
          component: () => import(/* webpackChunkName: 'recruitments' */ '@views/recruitments/Index'),
          children: [
            {
              path: 'search',
              name: 'recruitments_search_path',
              component: () => import(/* webpackChunkName: 'recruitments_search' */ '@views/recruitments/Search'),
            },
            {
              path: 'overview',
              name: 'recruitments_overview_path',
              component: () => import(/* webpackChunkName: 'recruitments_overview' */ '@views/recruitments/Overview'),
              beforeEnter: recruiterAuthorizedGuard
            },
            {
              path: 'new',
              name: 'new_recruitment_path',
              component: () => import(/* webpackChunkName: 'new_recruitment' */ '@views/recruitments/New'),
              beforeEnter: recruiterAuthorizedGuard
            },
            {
              path: ':publicRecruitId/documents/:id',
              name: 'recruitment_path',
              component: () => import(/* webpackChunkName: 'recruitment' */ '@views/recruitments/Show'),
            },
            {
              path: ':publicRecruitId/documents/:id/edit',
              name: 'edit_recruitment_path',
              component: () => import(/* webpackChunkName: 'edit_recruitment' */ '@views/recruitments/Edit'),
              beforeEnter: recruiterAuthorizedGuard
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
          beforeEnter: adminAuthorizedGuard,
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
              path: 'notifications',
              name: 'notifications_settings_path',
              component: () => import(/* webpackChunkName: 'settings_notifications' */ '@views/settings/Notifications'),
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
      beforeEnter: alreadyAuthenticatedGuard
    },
    {
      path: '/passwords/forgot',
      name: 'forgot_password_path',
      component: () => import(/* webpackChunkName: 'forgot_password' */ '@views/auth/ForgotPassword'),
      beforeEnter: alreadyAuthenticatedGuard
    },
    {
      path: '/passwords/reset',
      name: 'reset_password_path',
      component: () => import(/* webpackChunkName: 'reset_password' */ '@views/auth/ResetPassword'),
      beforeEnter: alreadyAuthenticatedGuard
    },
    {
      path: '/invitations/accept',
      name: 'accept_invitation_path',
      component: () => import(/* webpackChunkName: 'accept_invitation' */ '@views/auth/SetupPassword'),
      beforeEnter: alreadyAuthenticatedGuard
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
