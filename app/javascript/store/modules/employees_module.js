import http from '@/lib/http_config'

import { Employee, EmployeesList } from '@models/employee'

const initialState = () => ({
  employees: new EmployeesList(),
  loading: true
})

const EmployeesModule = {
  namespaced: true,

  state: initialState(),

  getters: {
    employees: state => state.employees,
    loading: state => state.loading
  },

  mutations: {
    setList(state, employees) {
      state.employees = new EmployeesList(employees)
      state.loading = false
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
    index({ commit }) {
      commit('setLoading', true)

      http.get(Employee.routes.employeesPath)
        .then(response => {
          commit('setList', response.data)
        })
        .catch(() => {
          commit('FlashStore/push', { error: 'Error :(' }, { root: true })
        })
        .finally(() => commit('setLoading', false))
    }
  }
}

export default EmployeesModule
