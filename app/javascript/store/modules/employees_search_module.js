import http from '@/lib/http_config'

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
      return state
    },
    setLoading(state, status) {
      state.loading = status
      return state
    },
    setSkills(state, skills) {
      state.skills = skills
      return state
    },
    setQuery(state, query) {
      state.query = query
      return state
    },
    resetState(state) {
      state.employees = new EmployeesList()
      state.query = new EmployeesSearchQuery()
      return state
    }
  },

  actions: {
    skills({ commit }) {
      http.get(Employee.routes.employeesSkillsPath)
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

      http.get(Employee.routes.employeesSearchPath, { params: query.attributes })
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
