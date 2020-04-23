import { coreApiClient } from '@utils/api_clients'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { Evaluation, EvaluationsList } from '@models/evaluation'
import { EmployeesList } from '@models/employee'
import { TemplatesList } from '@models/template'
import { SectionsList } from '@models/section'

const initState = () => ({
  evaluations: new EvaluationsList(),
  evaluation: new Evaluation(),
  sections: new SectionsList(),
  employees: new EmployeesList(),
  templates: new TemplatesList(),
  loading: true
})

const EvaluationEmployablesModule = {
  namespaced: true,

  state: initState(),

  mutations: {
    ADD_EVALUATION(state, data) {
      state.evaluations.unshift(data)
    },
    CLEAR_EVALUATION(state) {
      state.evaluation = new Evaluation()
      state.sections = new SectionsList()
    },
    SET_FORM_DATA(state, { employees, templates }) {
      state.employees = new EmployeesList(employees)
      state.templates = new TemplatesList(templates)
    },
    REFRESH_SECTION(state, section) {
      state.sections.refresh(section)
    },
    REMOVE_EVALUATION(state, id) {
      state.evaluation = new Evaluation()
      state.sections = new SectionsList()
      state.evaluations.dropById(id)
    },
    RESET_STATE(state) {
      Object.assign(state, initState())
    },
    SET_EVALUATION(state, { evaluation, sections }) {
      state.evaluation = new Evaluation(evaluation)
      state.sections = new SectionsList(sections)
    },
    SET_EVALUATIONS(state, evaluations) {
      state.evaluations = new EvaluationsList(evaluations)
    },
    SET_LOADING(state, status) {
      state.loading = status
    }
  },
  actions: {
    fetchEvaluations({ commit }) {
      commit('SET_LOADING', true)

      coreApiClient
        .get(Evaluation.routes.evaluationEmployablesPath)
        .then(response => {
          commit('SET_EVALUATIONS', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/PUSH_NOTIFICATION',
            { error: i18n.t('messages.evaluations.index.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', false))
    },
    fetchEvaluation({ commit }, id) {
      coreApiClient
        .get(Evaluation.routes.draftEvaluationEmployablePath(id))
        .then(response => {
          commit('SET_EVALUATION', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/PUSH_NOTIFICATION',
            { error: i18n.t('messages.evaluations.show.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
    },
    fetchFormData({ commit }) {
      coreApiClient
        .get(Evaluation.routes.evaluationEmployableFormPath)
        .then(response => commit('SET_FORM_DATA', response.data))
    },
    createEvaluation({ commit }, { employeeId, templateId, useLatest }) {
      const params = {
        evaluation: {
          employee_id: employeeId,
          template_id: templateId,
          use_latest: useLatest
        }
      }

      return new Promise(resolve => {
        coreApiClient
          .post(Evaluation.routes.evaluationEmployablesPath, params)
          .then(response => {
            commit('ADD_EVALUATION', response.data.evaluation)

            commit(
              'NotificationsModule/PUSH_NOTIFICATION',
              { success: i18n.t('messages.evaluations.create.ok') },
              { root: true }
            )

            resolve(response.data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/PUSH_NOTIFICATION',
              { error: i18n.t('messages.evaluations.create.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
        })
    },
    updateEvaluation({ state, commit }) {
      const { evaluation, sections } = state;

      const params = {
        evaluation: {
          sections: sections.models
        }
      }

      return new Promise(resolve => {
        coreApiClient
          .put(Evaluation.routes.evaluationEmployablePath(evaluation.id), params)
          .then(response => {
            commit('SET_EVALUATION', response.data)

            commit(
              'NotificationsModule/PUSH_NOTIFICATION',
              { success: i18n.t('messages.evaluations.update.ok') },
              { root: true }
            )

            resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/PUSH_NOTIFICATION',
              { error: i18n.t('messages.evaluations.update.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })

    },
    completeEvaluation({ state, commit }, nextEvaluationDate) {
      const { evaluation, sections } = state;

      const params = {
        evaluation: {
          state: 'completed',
          next_evaluation_on: nextEvaluationDate,
          sections: sections.models
        }
      }

      return new Promise(resolve => {
        coreApiClient
          .put(Evaluation.routes.evaluationEmployablePath(evaluation.id), params)
          .then(() => {
            commit('REMOVE_EVALUATION', evaluation.id)

            commit(
              'NotificationsModule/PUSH_NOTIFICATION',
              { success: i18n.t('messages.evaluations.complete.ok') },
              { root: true }
            )

            resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/PUSH_NOTIFICATION',
              { error: i18n.t('messages.evaluations.complete.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    removeEvaluation({ state, commit }) {
      const { evaluation } = state;

      coreApiClient
        .delete(Evaluation.routes.evaluationEmployablePath(evaluation.id))
        .then(() => {
          commit('REMOVE_EVALUATION', evaluation.id)

          commit(
            'NotificationsModule/PUSH_NOTIFICATION',
            { success: i18n.t('messages.evaluations.delete.ok') },
            { root: true }
          )
        })
        .catch(error => {
          commit(
            'NotificationsModule/PUSH_NOTIFICATION',
            { error: i18n.t('messages.evaluations.delete.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
    }
  }
}

export default EvaluationEmployablesModule
