import http from '@utils/http'

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

  getters: {
    groups: state => state.groups,
    positionsChartData: state => state.positionsChartData,
    employeesPastYearChartData: state => state.employeesPastYearChartData,
    employeesAnalytics: state => state.employeesAnalytics,
    employeesByUsersChartData: state => state.employeesByUsersChartData,
    evaluationsPastYearChartData: state => state.evaluationsPastYearChartData,
    evaluationsAnalytics: state => state.evaluationsAnalytics,
    loading: state => state.loading
  },

  mutations: {
    setData(state, data) {
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

      return state
    },
    setLoading(state, status) {
      state.loading = status
      return state
    },
    resetState(state) {
      state = Object.assign(state, initialState())
      return state
    }
  },

  actions: {
    overview({ commit }) {
      commit('setLoading', true)

      http.get(Employee.routes.employeesOverviewPath)
        .then(response => {
          commit('setData', response.data)
        })
        .catch(() => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.employees.overview.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('setLoading', false))
    }
  }
}

export default EmployeesOverviewModule
