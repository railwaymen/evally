import axios from 'axios'

import { coreApiClient, recruitableApiClient } from '@utils/api_clients'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { AttachmentsList } from '@models/attachment'
import { Evaluation, EvaluationsList } from '@models/evaluation'
import { RecruitDocument, RecruitDocumentsList } from '@models/recruit_document'
import { SectionsList } from '@models/section'
import { TemplatesList } from '@models/template'

const initialState = () => ({
  recruitDocuments: new RecruitDocumentsList(),
  recruitDocument: new RecruitDocument(),
  attachments: new AttachmentsList(),
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
    attachments: state => state.attachments,
    templates: state => state.templates,
    evaluations: state => state.evaluations,
    evaluation: state => state.evaluation,
    sections: state => state.sections,
    groups: state => state.groups,
    statuses: state => state.statuses,
    positions: state => state.positions,
    loading: state => state.loading
  },

  mutations: {
    addEvaluation(state, { evaluation, sections }) {
      state.evaluation = new Evaluation(evaluation)
      state.sections = new SectionsList(sections)
      state.evaluations.add(evaluation)
    },
    addRecruitDocument(state, recruitDocument) {
      state.recruitDocument = new RecruitDocument(recruitDocument)
      state.recruitDocuments.add(recruitDocument)
    },
    clearRecruitDocument(state) {
      state.recruitDocument = new RecruitDocument()
      state.attachments = new AttachmentsList()
    },
    replaceSection(state, section) {
      state.sections.replace(section)
    },
    removeEvaluation(state, id) {
      state.evaluation = new Evaluation()
      state.sections = new SectionsList()
      state.evaluations.remove(id)
    },
    removeAttachment(state, id) {
      state.attachments.remove(id)
    },
    setEvaluation(state, { evaluation, sections }) {
      state.evaluation = new Evaluation(evaluation)
      state.sections = new SectionsList(sections)
      state.evaluations.refresh(evaluation)
    },
    setAttachments(state, attachments) {
      state.attachments = new AttachmentsList(attachments)
    },
    setRecruit(state, data) {
      const { evaluations, evaluation, sections, templates } = data

      state.evaluations = new EvaluationsList(evaluations)
      state.evaluation = new Evaluation(evaluation)
      state.sections = new SectionsList(sections)
      state.templates = new TemplatesList(templates)
    },
    setRecruitDocument(state, data) {
      const {
        recruit_document,
        attachments,
        positions,
        statuses,
        groups
      } = data

      state.recruitDocument = new RecruitDocument(recruit_document)
      state.attachments = new AttachmentsList(attachments)
      state.positions = positions
      state.groups = groups
      state.statuses = statuses
    },
    setRecruitDocuments(state, data) {
      const {
        recruit_documents,
        groups,
        statuses,
        positions
      } = data

      state.recruitDocuments = new RecruitDocumentsList(recruit_documents)
      state.positions = positions
      state.statuses = statuses
      state.groups = groups
    },
    setLoading(state, status) {
      state.loading = status
    },
    resetState(state) {
      Object.assign(state, initialState())
    },
    updateRecruitDocument(state, recruitDocument) {
      state.recruitDocument = new RecruitDocument(recruitDocument)
      state.recruitDocuments.refresh(recruitDocument)
    }
  },

  actions: {
    index({ commit }) {
      commit('setLoading', true)

      recruitableApiClient
        .get(RecruitDocument.routes.recruitDocumentsPath)
        .then(response => {
          commit('setRecruitDocuments', response.data)
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

      recruitableApiClient
        .get(RecruitDocument.routes.recruitDocumentsFilterPath(filters))
        .then(response => {
          commit('setRecruitDocuments', response.data)
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
    show({ commit }, { publicRecruitId, id }) {
      commit('setLoading', true)

      axios
        .all([
          recruitableApiClient.get(RecruitDocument.routes.recruitDocumentPath(id)),
          coreApiClient.get(RecruitDocument.routes.recruitPath(publicRecruitId))
        ])
        .then(axios.spread((recruitableApiResponse, coreApiResponse) => {
          commit('setRecruitDocument', recruitableApiResponse.data)
          commit('setRecruit', coreApiResponse.data)
        }))
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.recruitments.show.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('setLoading', false))
    },
    newForm({ commit }) {
      recruitableApiClient
        .get(RecruitDocument.routes.recruitDocumentsNewFormPath)
        .then(response => {
          commit('setRecruitDocument', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.recruitments.show.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
    },
    create({ commit }, { recruitDocument, attachments }) {
      const formData = new FormData();

      for (let key in recruitDocument) {
        formData.append(`recruit_document[${key}]`, recruitDocument[key]);
      }

      attachments.map(attachment => formData.append('recruit_document[files][]', attachment))

      return (
        recruitableApiClient
          .post(RecruitDocument.routes.recruitDocumentsPath, formData)
          .then(response => {
            commit('addRecruitDocument', response.data)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.recruitments.create.ok') },
              { root: true }
            )

            return Promise.resolve(response.data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.recruitments.create.error', { msg: fetchError(error) }) },
              { root: true }
            )

          })
      )
    },
    update({ commit }, recruitDocument) {
      const params = {
        recruit_document: recruitDocument.attributes
      }

      return (
        recruitableApiClient
          .put(RecruitDocument.routes.recruitDocumentPath(recruitDocument.id), params)
          .then(response => {
            commit('updateRecruitDocument', response.data)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.recruitments.update.ok') },
              { root: true }
            )

            return Promise.resolve(response.data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.recruitments.update.error', { msg: fetchError(error) }) },
              { root: true }
            )

          })
      )
    },
    uploadAttachments({ state, commit }, attachments) {
      const headers = { 'Content-Type': 'multipart/form-data' }

      const formData = new FormData();
      attachments.map(attachment => formData.append('files[]', attachment))

      return (
        recruitableApiClient
          .post(RecruitDocument.routes.attachmentsPath(state.recruitDocument.id), formData, { headers })
          .then(response => {
            commit('setAttachments', response.data)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.recruitments.uploadAttachments.ok') },
              { root: true }
            )

            return Promise.resolve(response.data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.recruitments.uploadAttachments.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    },
    destroyAttachment({ state, commit }, id) {
      return (
        recruitableApiClient
          .delete(RecruitDocument.routes.attachmentPath(state.recruitDocument.id, id))
          .then(() => {
            commit('removeAttachment', id)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.recruitments.destroyAttachment.ok') },
              { root: true }
            )

            return Promise.resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.recruitments.destroyAttachment.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    },
    showEvaluation({ state, commit }, evaluationId) {
      const { id, recruit_id } = state.evaluations.findById(evaluationId)

      if (Number(state.evaluation.id) !== Number(evaluationId)) commit('setLoading', true)

      coreApiClient
        .get(Evaluation.routes.showEvaluationRecruitablePath(recruit_id, id))
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
        .finally(() => commit('setLoading', false))
    },
    createEvaluation({ state, commit }, { templateId }) {
      const params = {
        evaluation: {
          public_recruit_id: state.recruitDocument.public_recruit_id,
          position: state.recruitDocument.position,
          template_id: templateId
        }
      }

      commit('setLoading', true)

      return (
        coreApiClient
          .post(Evaluation.routes.evaluationRecruitablesPath, params)
          .then(response => {
            commit('addEvaluation', response.data)
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
          .finally(() => commit('setLoading', false))
      )
    },
    updateEvaluation({ state, commit }) {
      const params = {
        evaluation: {
          sections: state.sections.models
        }
      }

      return (
        coreApiClient
          .put(Evaluation.routes.evaluationRecruitablePath(state.evaluation.id), params)
          .then(response => {
            commit('setEvaluation', response.data)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.evaluations.update.ok') },
              { root: true }
            )

            return Promise.resolve(response.data)
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
    completeEvaluation({ state, commit }) {
      const { evaluation, sections } = state;

      const params = {
        evaluation: {
          state: 'completed',
          sections: sections.models
        }
      }

      return (
        coreApiClient
          .put(Evaluation.routes.evaluationRecruitablePath(evaluation.id), params)
          .then((response) => {
            commit('setEvaluation', response.data)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.evaluations.complete.ok') },
              { root: true }
            )

            return Promise.resolve(response.data)
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
    destroyEvaluation({ state, commit }) {
      const { evaluation } = state;

      coreApiClient
        .delete(Evaluation.routes.evaluationRecruitablePath(evaluation.id))
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
