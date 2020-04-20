import { coreApiClient } from '@utils/api_clients'

import { EmployeesList } from '@models/employee'
import { EvaluationsList } from '@models/evaluation'
import { TemplatesList } from '@models/template'

const initState = () => ({
  employees: new EmployeesList(),
  drafts: new EvaluationsList(),
  templates: new TemplatesList(),
  loading: true
})

const DashboardModule = {
  namespaced: true,

  state: initState(),

  mutations: {
    SET_DATA(state, { employees, drafts, templates }) {
      state.employees = new EmployeesList(employees)
      state.drafts = new EvaluationsList(drafts)
      state.templates = new TemplatesList(templates)
    },
    SET_LOADING(state, status) {
      state.loading = status
    },
    RESET_STATE(state) {
      Object.assign(state, initState())
    }
  },

  actions: {
    fetchDashboardData({ commit }) {
      commit('SET_LOADING', true)

      coreApiClient
        .get('/v2/dashboard')
        .then(response => {
          commit('SET_DATA', response.data)
        })
        .catch(() => {
          commit('NotificationsModule/PUSH_NOTIFICATION', { error: 'Error :(' }, { root: true })
        })
        .finally(() => commit('SET_LOADING', false))
    }
  }
}

export default DashboardModule
