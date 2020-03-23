import { coreApiClient } from '@utils/api_clients'

import { Employee, EmployeesList } from '@models/employee'
import { EmployeesSearchQuery } from '@models/employees_search_query'

const initialState = () => ({
  employees: new EmployeesList(),
  query: new EmployeesSearchQuery(),
  skills: [],
  loading: false
})

const EmployeesModule = {
  namespaced: true,

  state: initialState(),

  getters: {
    employees: state => state.employees,
    query: state => state.query,
    skills: state => state.skills,
    loading: state => state.loading
  },

  mutations: {
    setEmployees(state, employees) {
      state.employees = new EmployeesList(employees)
    },
    setLoading(state, status) {
      state.loading = status
    },
    setSkills(state, skills) {
      state.skills = skills
    },
    setQuery(state, query) {
      state.query = query
    },
    resetState(state) {
      state.employees = new EmployeesList()
      state.query = new EmployeesSearchQuery()
    }
  },

  actions: {
    skills({ commit }) {
      coreApiClient
        .get(Employee.routes.employeesSkillsPath)
        .then(response => {
          commit('setSkills', response.data)
        })
        .catch(() => {
          commit(
            'NotificationsModule/push',
            { error: 'Error :(' },
            { root: true }
          )
        })
    },
    search({ commit }, query) {
      commit('setLoading', true)

      coreApiClient
        .get(Employee.routes.employeesSearchPath, { params: query.attributes })
        .then(response => {
          commit('setQuery', query)
          commit('setEmployees', response.data)
        })
        .catch(() => {
          commit(
            'NotificationsModule/push',
            { error: 'Error :(' },
            { root: true }
          )
        })
        .finally(() => commit('setLoading', false))
    }
  }
}

export default EmployeesModule
