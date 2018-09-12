import Vue from 'vue'
import Router from 'vue-router'

import DashboardPage from '../components/app/DashboardPage'
import EmployeesPage from '../components/app/EmployeesPage'
import EvaluationsPage from '../components/app/EvaluationsPage'
import SchedulePage from '../components/app/SchedulePage'
import SettingsPage from '../components/app/SettingsPage'
import SkillsPage from '../components/app/SkillsPage'
import TemplatesPage from '../components/app/TemplatesPage'

import ProfilePage from '../components/app/ProfilePage'

import LandingPage from '../components/LandingPage'
import Layout from '../components/Layout'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/app',
      component: Layout,
      children: [
        {
          path: '',
          name: 'dashboard_path',
          component: DashboardPage
        },
        {
          path: 'employees',
          name: 'employees_path',
          component: EmployeesPage
        },
        {
          path: 'evaluations',
          name: 'evaluations_path',
          component: EvaluationsPage
        },
        {
          path: 'templates',
          name: 'templates_path',
          component: TemplatesPage
        },
        {
          path: 'skills',
          name: 'skills_path',
          component: SkillsPage
        },
        {
          path: 'schedule',
          name: 'schedule_path',
          component: SchedulePage
        },
        {
          path: 'settings',
          name: 'settings_path',
          component: SettingsPage
        },
        {
          path: 'profile',
          name: 'profile_path',
          component: ProfilePage
        }
      ]
    },
    {
      path: '/',
      name: 'landing_page_path',
      component: LandingPage
    },
    {
      path: '*',
      redirect: '/'
    }
  ]
})
