import http from '@/lib/http_config'

import { Employee, EmployeesList } from '@models/employee'
import { EvaluationsList } from '@models/evaluation'
import { PositionChangesList } from '@models/position_change'

const initialState = () => ({
  employees: new EmployeesList(),
  employee: new Employee(),
  evaluations: new EvaluationsList(),
  positionChanges: new PositionChangesList(),
  loading: true
})

const EmployeesModule = {
  namespaced: true,

  state: initialState(),

  getters: {
    employees: state => state.employees,
    employee: state => state.employee,
    evaluations: state => state.evaluations,
    positionChanges: state => state.positionChanges,
    loading: state => state.loading
  },

  mutations: {
    addToList(state, data) {
      state.employees.add(data)
      return state
    },
    refreshListItem(state, data) {
      state.employees.refresh(data)
      return state
    },
    setItem(state, { employee, evaluations, position_changes }) {
      state.employee = new Employee(employee)
      state.evaluations = new EvaluationsList(evaluations)
      state.positionChanges = new PositionChangesList(position_changes)
      return state
    },
    setList(state, employees) {
      state.employees = new EmployeesList(employees)
      state.loading = false
      return state
    },
    setLoading(state, status) {
      state.loading = status
      return state
    },
    resetItem(state) {
      state.employee = new Employee()
      state.evaluations = new EvaluationsList()
      state.positionChanges = new PositionChangesList()
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
    },
    show({ commit }, id) {
      http.get(Employee.routes.employeePath(id))
        .then(response => {
          commit('setItem', response.data)
        })
        .catch(() => {
          commit('FlashStore/push', { error: 'Error :(' }, { root: true })
        })
    },
    create({ commit }, employee) {
      const params = {
        employee: employee.attributes
      }

      return new Promise(resolve => {
        http.post(Employee.routes.employeesPath, params)
          .then(response => {
            const { data } = response

            commit('addToList', data)
            commit('FlashStore/push', { success: 'Created :)' }, { root: true })

            resolve(data)
          })
          .catch(() => {
            commit('FlashStore/push', { error: 'Error :(' }, { root: true })
          })
      })
    },
    update({ commit }, employee) {
      const params = {
        employee: employee.attributes
      }

      return new Promise(resolve => {
        http.put(Employee.routes.employeePath(employee.id), params)
          .then(response => {
            const { data } = response

            commit('refreshListItem', data)
            commit('FlashStore/push', { success: 'Updated :)' }, { root: true })

            resolve(data)
          })
          .catch(() => {
            commit('FlashStore/push', { error: 'Error :(' }, { root: true })
          })
      })
    }
  }
}

export default EmployeesModule
