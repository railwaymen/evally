import { coreApiClient } from '@utils/api_clients'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { Employee, EmployeesList } from '@models/employee'
import { Evaluation, EvaluationsList } from '@models/evaluation'
import { SectionsList } from '@models/section'
import { PositionChangesList } from '@models/position_change'
import { UsersList } from '@models/user'

const initState = () => ({
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

  state: initState(),

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
    ADD_EMPLOYEE(state, employee) {
      state.employees.unshift(employee)
    },
    CLEAR_EMPLOYEE(state) {
      state.employee = new Employee()
      state.evaluations = new EvaluationsList()
      state.positionChanges = new PositionChangesList()
    },
    CLEAR_EVALUATION(state) {
      state.evaluation = new Evaluation()
      state.sections = new SectionsList()
    },
    REFRESH_EMPLOYEE(state, employee) {
      state.employee.assign(employee)
      state.employees.refresh(employee)
    },
    REMOVE_EMPLOYEE(state, id) {
      state.employee = new Employee()
      state.employees.dropById(id)
    },
    RESET_STATE(state) {
      Object.assign(state, initState())
    },
    SET_LOADING(state, status) {
      state.loading = status
    },
    SET_EMPLOYEE(state, { employee, evaluations, position_changes }) {
      state.employee = new Employee(employee)
      state.evaluations = new EvaluationsList(evaluations)
      state.positionChanges = new PositionChangesList(position_changes)
    },
    SET_EMPLOYEES(state, { employees, evaluators }) {
      state.employees = new EmployeesList(employees)
      state.evaluators = new UsersList(evaluators)
      state.loading = false
    },
    SET_EVALUATION(state, { evaluation, sections }) {
      state.evaluation = new Evaluation(evaluation)
      state.sections = new SectionsList(sections)
    }
  },

  actions: {
    fetchEmployees({ commit }) {
      commit('SET_LOADING', true)

      coreApiClient
        .get(Employee.routes.employeesPath)
        .then(response => {
          commit('SET_EMPLOYEES', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.employees.index.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', false))
    },
    fetchArchivedEmployees({ commit }) {
      commit('SET_LOADING', true)

      coreApiClient
        .get(Employee.routes.employeesArchivedPath)
        .then(response => {
          commit('SET_EMPLOYEES', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.employees.index.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', false))
    },
    fetchEmployee({ commit }, id) {
      coreApiClient
        .get(Employee.routes.employeePath(id))
        .then(response => {
          commit('SET_EMPLOYEE', response.data)
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
          commit('SET_EVALUATION', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.employees.showEvaluation.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
    },
    browseEmployee({ commit }, id) {
      coreApiClient
        .get(Employee.routes.browseEmployeePath(id))
        .then(response => {
          commit('SET_EMPLOYEE', response.data)
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
          commit('SET_EVALUATION', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.employees.showEvaluation.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
    },
    createEmployee({ commit }, employee) {
      return (
        coreApiClient
          .post(Employee.routes.employeesPath, { employee })
          .then(response => {
            commit('ADD_EMPLOYEE', response.data)

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
    updateEmployee({ commit }, employee) {
      return (
        coreApiClient
          .put(Employee.routes.employeePath(employee.id), { employee })
          .then(response => {
            commit('REFRESH_EMPLOYEE', response.data)

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
    removeEmployee({ state, commit }) {
      const { employee } = state;

      return (
        coreApiClient
          .delete(Employee.routes.employeePath(employee.id))
          .then(() => {
            commit('REMOVE_EMPLOYEE', employee.id)

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
    archiveEmployee({ commit, state }, archivedDate){
      const params = { employee: { archived_on: archivedDate } }

      return (
        coreApiClient
          .put(Employee.routes.employeeArchivePath(state.employee.id), params)
          .then(response => {
            commit('REFRESH_EMPLOYEE', response.data)

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
