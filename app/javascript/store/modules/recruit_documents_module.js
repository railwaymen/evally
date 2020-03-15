import http from '@utils/http'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { Evaluation, EvaluationsList } from '@models/evaluation'
import { RecruitDocument, RecruitDocumentsList } from '@models/recruit_document'
import { SectionsList } from '@models/section'
import { TemplatesList } from '@models/template'

const initialState = () => ({
  recruitDocuments: new RecruitDocumentsList(),
  recruitDocument: new RecruitDocument(),
  evaluations: new EvaluationsList(),
  evaluation: new Evaluation(),
  sections: new SectionsList(),
  templates: new TemplatesList(),
  groups: [],
  statuses: [],
  positions: [],
  loading: true
})

const RecruitDocumentsModule = {
  namespaced: true,

  state: initialState(),

  getters: {
    recruitDocuments: state => state.recruitDocuments,
    recruitDocument: state => state.recruitDocument,
    templates: state => state.templates,
    evaluations: state => state.evaluations,
    evaluation: state => state.evaluation,
    sections: state => state.sections,
    groups: state => state.groups,
    statuses: state => state.statuses,
    positions: state => state.positions,
    loading: state => state.loading
  },

  mutations:{
    setLoading(state, status) {
      state.loading = status
      return state
    },
    setEvaluation(state, { evaluation, sections }) {
      state.evaluations.refresh(evaluation)
      state.evaluation = new Evaluation(evaluation)
      state.sections = new SectionsList(sections)
      return state
    },
    setList(state, { recruit_documents, groups, statuses, positions }) {
      state.recruitDocuments = new RecruitDocumentsList(recruit_documents)
      state.groups = groups
      state.statuses = statuses
      state.positions = positions
      state.loading = false
      return state
    },
    setItem(state, data) {
      const {
        recruit_document,
        evaluations,
        evaluation,
        sections,
        templates
      } = data

      state.recruitDocument = new RecruitDocument(recruit_document)
      state.evaluations = new EvaluationsList(evaluations)
      state.evaluation = new Evaluation(evaluation)
      state.sections = new SectionsList(sections)
      state.templates = new TemplatesList(templates)
      state.loading = false
      return state
    },
    replaceSection(state, section) {
      state.sections.replace(section)
      return state
    },
    resetState(state) {
      state = Object.assign(state, initialState())
      return state
    },
    addEvaluation(state, { evaluation, sections }) {
      state.evaluation = new Evaluation(evaluation)
      state.sections = new SectionsList(sections)
      state.evaluations.add(evaluation)
      return state
    },
    removeEvaluation(state, id) {
      state.evaluation = new Evaluation()
      state.sections = new SectionsList()
      state.evaluations.remove(id)
      return state
    },
    addToList(state, recruitDocument) {
      state.recruitDocuments.add(recruitDocument)
      return state
    },
  },

  actions: {
    index({ commit }) {
      commit('setLoading', true)

      http.get(RecruitDocument.routes.recruitDocumentsPath)
        .then(response => {
          commit('setList', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.recruitments.index.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('setLoading', false))
    },
    filterIndex({ commit }, filters) {
      commit('setLoading', true)

      http.get(RecruitDocument.routes.recruitDocumentsFilterPath(filters))
        .then(response => {
          commit('setList', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.recruitments.index.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('setLoading', false))
    },
    show({ commit }, id) {
      commit('setLoading', true)

      http.get(RecruitDocument.routes.recruitDocumentPath(id))
        .then(response => {
          commit('setItem', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.recruitments.show.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
    },
    new({ commit }) {
      commit('setLoading', true)
      http.get(RecruitDocument.routes.newRecruitDocumentsPath)
        .then(response => {
          commit('setList', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.recruitments.show.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
    },
    create({ commit }, recruitDocument ) {
      const params = {
        recruit_document: recruitDocument.attributes
      }

      return new Promise(resolve => {
        http.post(RecruitDocument.routes.recruitDocumentsPath, params)
          .then(response => {
            const { data } = response

            commit('addToList', data)
            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.recruitments.create.ok') },
              { root: true }
            )
            resolve(data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.recruitments.create.error', { msg: fetchError(error) }) },
              { root: true }
            )

          })
      })
    },
    createEvaluation({ state, commit }, { templateId }) {
      const params = {
        evaluation: {
          recruit_document_id: state.recruitDocument.id,
          template_id: templateId
        }
      }

      return new Promise(resolve => {
        http.post(Evaluation.routes.evaluationRecruitablesPath, params)
          .then(response => {
            const { data } = response

            commit('addEvaluation', data)
            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.evaluations.create.ok') },
              { root: true }
            )

            resolve(data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.evaluations.create.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    showEvaluation({ state, commit }, evaluationId) {
      const { id, recruit_id } = state.evaluations.findById(evaluationId)

      http.get(Evaluation.routes.showEvaluationRecruitablePath(recruit_id, id))
        .then(response => {
          commit('setEvaluation', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.evaluations.show.error', { msg: fetchError(error) }) },
            { root: true }
          )
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
        http.put(Evaluation.routes.evaluationRecruitablePath(evaluation.id), params)
          .then(response => {
            commit('setEvaluation', response.data)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.evaluations.update.ok') },
              { root: true }
            )

            resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.evaluations.update.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })

    },
    completeEvaluation({ state, commit }) {
      const { evaluation, sections } = state;

      const params = {
        evaluation: {
          state: 'completed',
          sections: sections.models
        }
      }

      return new Promise(resolve => {
        http.put(Evaluation.routes.evaluationRecruitablePath(evaluation.id), params)
          .then((response) => {
            commit('setEvaluation', response.data)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.evaluations.complete.ok') },
              { root: true }
            )

            resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.evaluations.complete.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    destroyEvaluation({ state, commit }) {
      const { evaluation } = state;

      http.delete(Evaluation.routes.evaluationRecruitablePath(evaluation.id))
        .then(() => {
          commit('removeEvaluation', evaluation.id)

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

export default RecruitDocumentsModule
