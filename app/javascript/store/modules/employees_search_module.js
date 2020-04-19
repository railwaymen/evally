import { coreApiClient } from '@utils/api_clients'

import { Employee, EmployeesList } from '@models/employee'
import { EmployeesSearchQuery } from '@models/employees_search_query'

const initialState = () => ({
  employees: new EmployeesList(),
  query: new EmployeesSearchQuery(),
  skills: [],
  loading: false
})

const EmployeesSearchModule = {
  namespaced: true,

  state: initialState(),

  mutations: {
    SET_EMPLOYEES(state, employees) {
      state.employees = new EmployeesList(employees)
    },
    SET_LOADING(state, status) {
      state.loading = status
    },
    SET_SKILLS(state, skills) {
      state.skills = skills
    },
    SET_QUERY(state, query) {
      state.query = query
    },
    RESET_STATE(state) {
      Object.assign(state, { ...initialState(), skills: state.skills })
    }
  },

  actions: {
    fetchSkills({ commit }) {
      coreApiClient
        .get(Employee.routes.employeesSkillsPath)
        .then(response => {
          commit('SET_SKILLS', response.data)
        })
        .catch(() => {
          commit(
            'NotificationsModule/push',
            { error: 'Error :(' },
            { root: true }
          )
        })
    },
    searchEmployees({ commit }, query) {
      commit('SET_LOADING', true)

      coreApiClient
        .get(Employee.routes.employeesSearchPath, { params: query })
        .then(response => {
          commit('SET_QUERY', query)
          commit('SET_EMPLOYEES', response.data)
        })
        .catch(() => {
          commit(
            'NotificationsModule/push',
            { error: 'Error :(' },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', false))
    }
  }
}

export default EmployeesSearchModule
