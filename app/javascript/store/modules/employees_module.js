import http from '@utils/http'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { Employee, EmployeesList } from '@models/employee'
import { Evaluation, EvaluationsList } from '@models/evaluation'
import { SectionsList } from '@models/section'
import { PositionChangesList } from '@models/position_change'

const initialState = () => ({
  employees: new EmployeesList(),
  employee: new Employee(),
  evaluations: new EvaluationsList(),
  evaluation: new Evaluation(),
  sections: new SectionsList(),
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
    evaluation: state => state.evaluation,
    sections: state => state.sections,
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
    setEvaluation(state, { evaluation, sections }) {
      state.evaluation = new Evaluation(evaluation)
      state.sections = new SectionsList(sections)
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
    resetEvaluation(state) {
      state.evaluation = new Evaluation()
      state.sections = new SectionsList()
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
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.employees.index.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('setLoading', false))
    },
    show({ commit }, id) {
      http.get(Employee.routes.employeePath(id))
        .then(response => {
          commit('setItem', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.employees.show.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
    },
    showEvaluation({ commit }, id) {
      http.get(Evaluation.routes.evaluationPath(id))
        .then(response => {
          commit('setEvaluation', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.employees.showEvaluation.error', { msg: fetchError(error) }) },
            { root: true }
          )
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
            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.employees.create.ok') },
              { root: true }
            )

            resolve(data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.employees.create.error', { msg: fetchError(error) }) },
              { root: true }
            )
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
            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.employees.update.ok') },
              { root: true }
            )

            resolve(data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.employees.update.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    }
  }
}

export default EmployeesModule
