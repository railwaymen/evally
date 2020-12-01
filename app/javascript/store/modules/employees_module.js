import { coreApiClient } from '@utils/api_clients'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import EmployeePolicy from '@policies/employee_policy'

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
  positions: [],
  groups: [],
  totalCount: 0,
  loading: 'fetch'
})

const EmployeesModule = {
  namespaced: true,

  state: initState(),

  getters: {
    fetchLoading: state => state.loading === 'fetch',
    formLoading: state => state.loading === 'form',
    employeePolicy: (state, _getters, rootState) => (
      new EmployeePolicy(rootState.AuthenticationModule.user, state.employee)
    )
  },

  mutations: {
    ADD_EMPLOYEE(state, employee) {
      state.employees.unshift(employee)
    },
    CHANGE_EMPLOYEE_STATUS(state, employee) {
      state.employee = new Employee(employee)
      state.employees.dropById(employee.id)
      state.totalCount -= 1
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
      state.totalCount -= 1
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
    SET_EMPLOYEES(state, { employees, evaluators, groups, total_count }) {
      state.employees = new EmployeesList(employees)
      state.evaluators = new UsersList(evaluators)
      state.groups = groups
      state.totalCount = total_count
    },
    SET_EVALUATION(state, { evaluation, sections }) {
      state.evaluation = new Evaluation(evaluation)
      state.sections = new SectionsList(sections)
    },
    SET_FORM_DATA(state, { positions, groups, evaluators }) {
      state.positions = positions
      state.groups = groups
      state.evaluators = new UsersList(evaluators)
    }
  },

  actions: {
    fetchEmployees({ commit }, query) {
      commit('SET_LOADING', 'fetch')

      coreApiClient
        .get(Employee.routes.employeesPath(query))
        .then(response => {
          commit('SET_EMPLOYEES', response.data)
        })
        .catch(error => {
          commit(
            'MessagesModule/PUSH_MESSAGE',
            { error: i18n.t('messages.employees.index.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', 'ok'))
    },
    fetchArchivedEmployees({ commit }, query) {
      commit('SET_LOADING', 'fetch')

      coreApiClient
        .get(Employee.routes.employeesArchivedPath(query))
        .then(response => {
          commit('SET_EMPLOYEES', response.data)
        })
        .catch(error => {
          commit(
            'MessagesModule/PUSH_MESSAGE',
            { error: i18n.t('messages.employees.index.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', 'ok'))
    },
    fetchFormData({ commit }) {
      commit('SET_LOADING', 'form')

      coreApiClient
        .get(Employee.routes.employeesFormPath)
        .then(response => commit('SET_FORM_DATA', response.data))
        .finally(() => commit('SET_LOADING', 'ok'))
    },
    fetchEmployee({ commit }, id) {
      commit('SET_LOADING', 'fetch')

      coreApiClient
        .get(Employee.routes.employeePath(id))
        .then(response => {
          commit('SET_EMPLOYEE', response.data)
        })
        .catch(error => {
          commit(
            'MessagesModule/PUSH_MESSAGE',
            { error: i18n.t('messages.employees.show.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', 'ok'))
    },
    showEvaluation({ commit }, { employeeId, id }) {
      coreApiClient
        .get(Evaluation.routes.completedEvaluationEmployablePath(employeeId, id))
        .then(response => {
          commit('SET_EVALUATION', response.data)
        })
        .catch(error => {
          commit(
            'MessagesModule/PUSH_MESSAGE',
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
            'MessagesModule/PUSH_MESSAGE',
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
            'MessagesModule/PUSH_MESSAGE',
            { error: i18n.t('messages.employees.showEvaluation.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
    },
    createEmployee({ commit }, employee) {
      return new Promise(resolve => {
        coreApiClient
          .post(Employee.routes.employeesPath, { employee })
          .then(response => {
            commit('ADD_EMPLOYEE', response.data)

            commit(
              'MessagesModule/PUSH_MESSAGE',
              { success: i18n.t('messages.employees.create.ok') },
              { root: true }
            )

            resolve(response.data)
          })
          .catch(error => {
            commit(
              'MessagesModule/PUSH_MESSAGE',
              { error: i18n.t('messages.employees.create.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    updateEmployee({ commit }, employee) {
      return new Promise(resolve => {
        coreApiClient
          .put(Employee.routes.employeePath(employee.id), { employee })
          .then(response => {
            commit('REFRESH_EMPLOYEE', response.data)

            commit(
              'MessagesModule/PUSH_MESSAGE',
              { success: i18n.t('messages.employees.update.ok') },
              { root: true }
            )

            resolve(response.data)
          })
          .catch(error => {
            commit(
              'MessagesModule/PUSH_MESSAGE',
              { error: i18n.t('messages.employees.update.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    removeEmployee({ state, commit }) {
      const { employee } = state;

      return new Promise(resolve => {
        coreApiClient
          .delete(Employee.routes.employeePath(employee.id))
          .then(() => {
            commit('REMOVE_EMPLOYEE', employee.id)

            commit(
              'MessagesModule/PUSH_MESSAGE',
              { success: i18n.t('messages.employees.delete.ok') },
              { root: true }
            )

            resolve()
          })
          .catch(error => {
            commit(
              'MessagesModule/PUSH_MESSAGE',
              { error: i18n.t('messages.employees.delete.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    archiveEmployee({ commit }, employee) {
      const params = {
        employee: {
          state: 'archived',
          archived_on: employee.archived_on
        }
      }

      return new Promise(resolve => {
        coreApiClient
          .put(Employee.routes.employeeArchivePath(employee.id), params)
          .then(response => {
            commit('CHANGE_EMPLOYEE_STATUS', response.data)

            commit(
              'MessagesModule/PUSH_MESSAGE',
              { success: i18n.t('messages.employees.archive.ok') },
              { root: true }
            )

            resolve(response.data)
          })
          .catch(error => {
            commit(
              'MessagesModule/PUSH_MESSAGE',
              { error: i18n.t('messages.employees.archive.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    restoreEmployee({ commit }, employee) {
      const params = {
        employee: {
          state: 'hired',
          archived_on: null
        }
      }

      return new Promise(resolve => {
        coreApiClient
          .put(Employee.routes.employeePath(employee.id), params)
          .then(response => {
            commit('CHANGE_EMPLOYEE_STATUS', response.data)

            commit(
              'MessagesModule/PUSH_MESSAGE',
              { success: i18n.t('messages.employees.restore.ok') },
              { root: true }
            )

            resolve(response.data)
          })
          .catch(error => {
            commit(
              'MessagesModule/PUSH_MESSAGE',
              { error: i18n.t('messages.employees.restore.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    }
  }
}

export default EmployeesModule
