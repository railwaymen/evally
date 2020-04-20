import { coreApiClient } from '@utils/api_clients'
import i18n from '@locales/i18n'
import { fetchError } from '@utils/helpers'

import { Employee } from '@models/employee'
import { EmployeesAnalytics } from '@models/employees_analytics'
import { EvaluationsAnalytics } from '@models/evaluations_analytics'

const initialState = () => ({
  groups: [],
  positionsChartData: [],
  employeesPastYearChartData: [],
  employeesAnalytics: new EmployeesAnalytics(),
  employeesByUsersChartData: [],
  evaluationsPastYearChartData: [],
  evaluationsAnalytics: new EvaluationsAnalytics(),
  loading: false
})

const EmployeesOverviewModule = {
  namespaced: true,

  state: initialState(),

  mutations: {
    SET_DATA(state, data) {
      const {
        groups,
        positions_chart_data,
        employees_past_year_chart_data,
        employees_analytics,
        employees_by_users_chart_data,
        evaluations_past_year_chart_data,
        evaluations_analytics
      } = data

      state.groups = groups
      state.positionsChartData = positions_chart_data
      state.employeesPastYearChartData = employees_past_year_chart_data
      state.employeesAnalytics = new EmployeesAnalytics(employees_analytics)
      state.employeesByUsersChartData = employees_by_users_chart_data
      state.evaluationsPastYearChartData = evaluations_past_year_chart_data
      state.evaluationsAnalytics = new EvaluationsAnalytics(evaluations_analytics)
    },
    SET_LOADING(state, status) {
      state.loading = status
    },
    RESET_STATE(state) {
      Object.assign(state, initialState())
    }
  },

  actions: {
    fetchData({ commit }) {
      commit('SET_LOADING', true)

      coreApiClient
        .get(Employee.routes.employeesOverviewPath)
        .then(response => {
          commit('SET_DATA', response.data)
        })
        .catch((error) => {
          commit(
            'NotificationsModule/PUSH_NOTIFICATION',
            { error: i18n.t('messages.employees.overview.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', false))
    }
  }
}

export default EmployeesOverviewModule
