import { coreApiClient } from '@utils/api_clients'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { Evaluation, EvaluationsList } from '@models/evaluation'
import { EmployeesList } from '@models/employee'
import { TemplatesList } from '@models/template'
import { SectionsList } from '@models/section'

const initialState = () => ({
  evaluations: new EvaluationsList(),
  evaluation: new Evaluation(),
  sections: new SectionsList(),
  employees: new EmployeesList(),
  templates: new TemplatesList(),
  loading: true
})

const EvaluationEmployablesModule = {
  namespaced: true,

  state: initialState(),

  getters: {
    evaluations: state => state.evaluations,
    evaluation: state => state.evaluation,
    sections: state => state.sections,
    employees: state => state.employees,
    templates: state => state.templates,
    loading: state => state.loading
  },
  mutations: {
    addToList(state, data) {
      state.evaluations.unshift(data)
    },
    setForm(state, { employees, templates }) {
      state.employees = new EmployeesList(employees)
      state.templates = new TemplatesList(templates)
    },
    setItem(state, { evaluation, sections }) {
      state.evaluation = new Evaluation(evaluation)
      state.sections = new SectionsList(sections)
    },
    setList(state, evaluations) {
      state.evaluations = new EvaluationsList(evaluations)
    },
    setLoading(state, status) {
      state.loading = status
    },
    removeFromList(state, id) {
      state.evaluation = new Evaluation()
      state.sections = new SectionsList()
      state.evaluations.dropById(id)
    },
    refreshSection(state, section) {
      state.sections.refresh(section)
    },
    resetItem(state) {
      state.evaluation = new Evaluation()
      state.sections = new SectionsList()
    },
    resetState(state) {
      Object.assign(state, initialState())
    }
  },
  actions: {
    index({ commit }) {
      commit('setLoading', true)

      coreApiClient
        .get(Evaluation.routes.evaluationEmployablesPath)
        .then(response => {
          commit('setList', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.evaluations.index.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('setLoading', false))
    },
    show({ commit }, id) {
      coreApiClient
        .get(Evaluation.routes.draftEvaluationEmployablePath(id))
        .then(response => {
          commit('setItem', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.evaluations.show.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
    },
    form({ commit }) {
      return (
        coreApiClient
          .get(Evaluation.routes.formEvaluationEmployablePath)
          .then(response => {
            commit('setForm', response.data)

            return Promise.resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.evaluations.show.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    },
    create({ commit }, { employeeId, templateId, useLatest }) {
      const params = {
        evaluation: {
          employee_id: employeeId,
          template_id: templateId,
          use_latest: useLatest
        }
      }

      return (
        coreApiClient
          .post(Evaluation.routes.evaluationEmployablesPath, params)
          .then(response => {
            commit('addToList', response.data.evaluation)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.evaluations.create.ok') },
              { root: true }
            )

            return Promise.resolve(response.data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.evaluations.create.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    },
    update({ state, commit }) {
      const { evaluation, sections } = state;

      const params = {
        evaluation: {
          sections: sections.models
        }
      }

      return (
        coreApiClient
          .put(Evaluation.routes.evaluationEmployablePath(evaluation.id), params)
          .then(response => {
            commit('setItem', response.data)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.evaluations.update.ok') },
              { root: true }
            )

            return Promise.resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.evaluations.update.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )

    },
    complete({ state, commit }, { nextEvaluationDate }) {
      const { evaluation, sections } = state;

      const params = {
        evaluation: {
          state: 'completed',
          next_evaluation_on: nextEvaluationDate,
          sections: sections.models
        }
      }

      return (
        coreApiClient
          .put(Evaluation.routes.evaluationEmployablePath(evaluation.id), params)
          .then(() => {
            commit('removeFromList', evaluation.id)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.evaluations.complete.ok') },
              { root: true }
            )

            return Promise.resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.evaluations.complete.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    },
    destroy({ state, commit }) {
      const { evaluation } = state;

      coreApiClient
        .delete(Evaluation.routes.evaluationEmployablePath(evaluation.id))
        .then(() => {
          commit('removeFromList', evaluation.id)

          commit(
            'NotificationsModule/push',
            { success: i18n.t('messages.evaluations.delete.ok') },
            { root: true }
          )
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.evaluations.delete.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
    }
  }
}

export default EvaluationEmployablesModule
