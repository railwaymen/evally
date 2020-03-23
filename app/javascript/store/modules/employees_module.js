import { coreApiClient } from '@utils/api_clients'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { Employee, EmployeesList } from '@models/employee'
import { Evaluation, EvaluationsList } from '@models/evaluation'
import { SectionsList } from '@models/section'
import { PositionChangesList } from '@models/position_change'
import { UsersList } from '@models/user'

const initialState = () => ({
  employees: new EmployeesList(),
  employee: new Employee(),
  evaluations: new EvaluationsList(),
  evaluation: new Evaluation(),
  sections: new SectionsList(),
  positionChanges: new PositionChangesList(),
  evaluators: new UsersList(),
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
    evaluators: state => state.evaluators,
    loading: state => state.loading
  },

  mutations: {
    addToList(state, data) {
      state.employees.add(data)
    },
    refreshItem(state, data) {
      state.employee.assign(data)
    },
    refreshListItem(state, data) {
      state.employees.refresh(data)
    },
    setEvaluation(state, { evaluation, sections }) {
      state.evaluation = new Evaluation(evaluation)
      state.sections = new SectionsList(sections)
    },
    setItem(state, { employee, evaluations, position_changes }) {
      state.employee = new Employee(employee)
      state.evaluations = new EvaluationsList(evaluations)
      state.positionChanges = new PositionChangesList(position_changes)
    },
    setList(state, { employees, evaluators }) {
      state.employees = new EmployeesList(employees)
      state.evaluators = new UsersList(evaluators)
      state.loading = false
    },
    setLoading(state, status) {
      state.loading = status
    },
    removeFromList(state, id) {
      state.employee = new Employee()
      state.employees.remove(id)
    },
    resetEvaluation(state) {
      state.evaluation = new Evaluation()
      state.sections = new SectionsList()
    },
    resetItem(state) {
      state.employee = new Employee()
      state.evaluations = new EvaluationsList()
      state.positionChanges = new PositionChangesList()
    },
    resetState(state) {
      Object.assign(state, initialState())
    }
  },

  actions: {
    index({ commit }) {
      commit('setLoading', true)

      coreApiClient
        .get(Employee.routes.employeesPath)
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
    archived({ commit }) {
      commit('setLoading', true)

      coreApiClient
        .get(Employee.routes.employeesArchivedPath)
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
      coreApiClient
        .get(Employee.routes.employeePath(id))
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
    showEvaluation({ commit }, { employeeId, id }) {
      coreApiClient
        .get(Evaluation.routes.completedEvaluationEmployablePath(employeeId, id))
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
    browse({ commit }, id) {
      coreApiClient
        .get(Employee.routes.browseEmployeePath(id))
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
    browseEvaluation({ commit }, { employeeId, id }) {
      coreApiClient
        .get(Evaluation.routes.browseEvaluationPath(employeeId, id))
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

      return (
        coreApiClient
          .post(Employee.routes.employeesPath, params)
          .then(response => {
            commit('addToList', response.data)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.employees.create.ok') },
              { root: true }
            )

            return Promise.resolve(response.data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.employees.create.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    },
    update({ commit }, employee) {
      const params = {
        employee: employee.attributes
      }

      return (
        coreApiClient
          .put(Employee.routes.employeePath(employee.id), params)
          .then(response => {
            commit('refreshListItem', response.data)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.employees.update.ok') },
              { root: true }
            )

            return Promise.resolve(response.data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.employees.update.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    },
    destroy({ state, commit }) {
      const { employee } = state;

      return (
        coreApiClient
          .delete(Employee.routes.employeePath(employee.id))
          .then(() => {
            commit('removeFromList', employee.id)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.employees.delete.ok') },
              { root: true }
            )

            return Promise.resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.employees.delete.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    },
    archive({ commit, state }, archivedDate){
      const params = { employee: { archived_on: archivedDate } }

      return (
        coreApiClient
          .put(Employee.routes.employeeArchivePath(state.employee.id), params)
          .then(response => {
            commit('refreshItem', response.data)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.employees.archive.ok') },
              { root: true }
            )

            return Promise.resolve(response.data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.employees.archive.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    }
  }
}

export default EmployeesModule
