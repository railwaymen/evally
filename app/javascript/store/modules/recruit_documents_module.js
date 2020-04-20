import axios from 'axios'

import { coreApiClient, recruitableApiClient } from '@utils/api_clients'
import { objectToFormData, fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { AttachmentsList } from '@models/attachment'
import { Comment, CommentsList } from '@models/comment'
import { Evaluation, EvaluationsList } from '@models/evaluation'
import { RecruitDocument, RecruitDocumentsList } from '@models/recruit_document'
import { SectionsList } from '@models/section'
import { TemplatesList } from '@models/template'
import { User, UsersList } from '@models/user'

const initialState = () => ({
  recruitDocuments: new RecruitDocumentsList(),
  recruitDocument: new RecruitDocument(),
  attachments: new AttachmentsList(),
  evaluators: new UsersList(),
  evaluations: new EvaluationsList(),
  evaluation: new Evaluation(),
  sections: new SectionsList(),
  templates: new TemplatesList(),
  comments: new CommentsList(),
  groups: [],
  statuses: [],
  positions: [],
  sources: [],
  loading: true
})

const RecruitDocumentsModule = {
  namespaced: true,

  state: initialState(),

  mutations: {
    ADD_COMMENT(state, comment) {
      state.comments.unshift(comment)
    },
    ADD_EVALUATION(state, { evaluation, sections }) {
      state.evaluation = new Evaluation(evaluation)
      state.sections = new SectionsList(sections)
      state.evaluations.unshift(evaluation)
    },
    ADD_RECRUIT_DOCUMENT(state, recruitDocument) {
      state.recruitDocument = new RecruitDocument(recruitDocument)
      state.recruitDocuments.unshift(recruitDocument)
    },
    CLEAR_RECRUIT_DOCUMENT(state) {
      state.recruitDocument = new RecruitDocument()
      state.attachments = new AttachmentsList()
    },
    REFRESH_SECTION(state, section) {
      state.sections.refresh(section)
    },
    REMOVE_EVALUATION(state, id) {
      state.evaluation = new Evaluation()
      state.sections = new SectionsList()
      state.evaluations.dropById(id)
    },
    REMOVE_ATTACHMENT(state, id) {
      state.attachments.dropById(id)
    },
    REMOVE_RECRUIT_DOCUMENT(state, id) {
      state.recruitDocument = new RecruitDocument()
      state.attachments = new AttachmentsList()
      state.recruitDocuments.dropById(id)
    },
    SET_EVALUATION(state, { evaluation, sections }) {
      state.evaluation = new Evaluation(evaluation)
      state.sections = new SectionsList(sections)
      state.evaluations.refresh(evaluation)
    },
    SET_EVALUATORS(state, evaluators) {
      state.evaluators = new UsersList(evaluators)
    },
    SET_ATTACHMENTS(state, attachments) {
      state.attachments = new AttachmentsList(attachments)
    },
    SET_RECRUIT(state, data) {
      const {
        evaluators,
        evaluations,
        evaluation,
        sections,
        templates,
        comments
      } = data

      state.evaluators = new UsersList(evaluators)
      state.evaluations = new EvaluationsList(evaluations)
      state.evaluation = new Evaluation(evaluation)
      state.sections = new SectionsList(sections)
      state.templates = new TemplatesList(templates)
      state.comments = new CommentsList(comments)
    },
    SET_RECRUIT_DOCUMENT(state, data) {
      const {
        recruit_document,
        attachments,
        positions,
        statuses,
        sources,
        groups
      } = data

      state.recruitDocument = new RecruitDocument(recruit_document)
      state.attachments = new AttachmentsList(attachments)
      state.positions = positions
      state.groups = groups
      state.statuses = statuses
      state.sources = sources
    },
    SET_RECRUIT_DOCUMENTS(state, data) {
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
    SET_LOADING(state, status) {
      state.loading = status
    },
    RESET_STATE(state) {
      Object.assign(state, initialState())
    },
    REFRESH_COMMENT(state, comment) {
      state.comments.refresh(comment)
    },
    REFRESH_RECRUIT_DOCUMENT(state, recruitDocument) {
      state.recruitDocument = new RecruitDocument(recruitDocument)
      state.recruitDocuments.refresh(recruitDocument)
    }
  },

  actions: {
    fetchRecruitDocuments({ commit }) {
      commit('SET_LOADING', true)

      recruitableApiClient
        .get(RecruitDocument.routes.recruitDocumentsPath)
        .then(response => {
          commit('SET_RECRUIT_DOCUMENTS', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.recruitments.index.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', false))
    },
    filterRecruitDocuments({ commit }, filters) {
      commit('SET_LOADING', true)

      recruitableApiClient
        .get(RecruitDocument.routes.recruitDocumentsFilterPath(filters))
        .then(response => {
          commit('SET_RECRUIT_DOCUMENTS', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.recruitments.index.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', false))
    },
    fetchRecruitDocument({ commit }, { publicRecruitId, id }) {
      commit('SET_LOADING', true)

      axios
        .all([
          recruitableApiClient.get(RecruitDocument.routes.recruitDocumentPath(id)),
          coreApiClient.get(RecruitDocument.routes.recruitPath(publicRecruitId))
        ])
        .then(axios.spread((recruitableApiResponse, coreApiResponse) => {
          commit('SET_RECRUIT_DOCUMENT', recruitableApiResponse.data)
          commit('SET_RECRUIT', coreApiResponse.data)
        }))
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.recruitments.show.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', false))
    },
    newRecruitDocument({ commit }) {
      axios
        .all([
          recruitableApiClient.get(RecruitDocument.routes.formRecruitDocumentPath),
          coreApiClient.get(User.routes.activeUsersPath)
        ])
        .then(axios.spread((recruitableApiResponse, coreApiResponse) => {
          commit('SET_RECRUIT_DOCUMENT', recruitableApiResponse.data)
          commit('SET_EVALUATORS', coreApiResponse.data)
        }))
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.recruitments.show.error', { msg: fetchError(error) }) },
            { root: true }
          )

        })
    },
    createRecruitDocument({ commit }, { recruitDocument, attachments = [] }) {
      const formData = objectToFormData(recruitDocument, 'recruit_document')
      attachments.map(attachment => formData.append('recruit_document[files][]', attachment))

      return (
        recruitableApiClient
          .post(RecruitDocument.routes.recruitDocumentsPath, formData)
          .then(response => {
            commit('ADD_RECRUIT_DOCUMENT', response.data)

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
    editForm({ commit }, id) {
      recruitableApiClient
        .get(RecruitDocument.routes.recruitDocumentPath(id))
        .then(response => {
          commit('SET_RECRUIT_DOCUMENT', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.recruitments.show.error', { msg: fetchError(error) }) },
            { root: true }
          )

        })
    },
    updateRecruitDocument({ commit }, { recruitDocument, attachments = [] }) {
      const formData = objectToFormData(recruitDocument, 'recruit_document')
      attachments.map(attachment => formData.append('recruit_document[files][]', attachment))

      return (
        recruitableApiClient
          .put(RecruitDocument.routes.recruitDocumentPath(recruitDocument.id), formData)
          .then(response => {
            commit('REFRESH_RECRUIT_DOCUMENT', response.data)

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
    removeRecruitDocument({ state, commit }) {
      const { recruitDocument } = state;

      return (
        recruitableApiClient
          .delete(RecruitDocument.routes.recruitDocumentPath(recruitDocument.id))
          .then(() => {
            commit('REMOVE_RECRUIT_DOCUMENT', recruitDocument.id)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.recruitments.destroy.ok') },
              { root: true }
            )

            return Promise.resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.recruitments.destroy.error', { msg: fetchError(error) }) },
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
            commit('SET_ATTACHMENTS', response.data)

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
    removeAttachment({ state, commit }, id) {
      return (
        recruitableApiClient
          .delete(RecruitDocument.routes.attachmentPath(state.recruitDocument.id, id))
          .then(() => {
            commit('REMOVE_ATTACHMENT', id)

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
    createComment({ state, commit }, comment) {
      const params = {
        comment: {
          body: comment.body
        }
      }

      return (
        coreApiClient
          .post(Comment.routes.commentsPath(state.recruitDocument.public_recruit_id), params)
          .then(response => {
            commit('ADD_COMMENT', response.data)
            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.comments.create.ok') },
              { root: true }
            )

            return Promise.resolve(response.data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.comments.create.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    },
    updateComment({ state, commit }, comment) {
      const params = {
        comment: {
          body: comment.body
        }
      }

      return (
        coreApiClient
          .put(Comment.routes.commentPath(state.recruitDocument.public_recruit_id, comment.id), params)
          .then(response => {
            commit('REFRESH_COMMENT', response.data)
            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.comments.update.ok') },
              { root: true }
            )

            return Promise.resolve(response.data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.comments.update.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    },
    removeComment({ state, commit }, id) {
      return (
        coreApiClient
          .delete(Comment.routes.commentPath(state.recruitDocument.public_recruit_id, id))
          .then(response => {
            commit('REFRESH_COMMENT', response.data)
            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.comments.delete.ok') },
              { root: true }
            )

            return Promise.resolve(response.data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.comments.delete.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    },
    fetchEvaluation({ state, commit }, evaluationId) {
      const { id, recruit_id } = state.evaluations.findById(evaluationId)

      if (Number(state.evaluation.id) !== Number(evaluationId)) commit('SET_LOADING', true)

      coreApiClient
        .get(Evaluation.routes.showEvaluationRecruitablePath(recruit_id, id))
        .then(response => {
          commit('SET_EVALUATION', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.evaluations.show.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', false))
    },
    createEvaluation({ state, commit }, { templateId }) {
      const params = {
        evaluation: {
          public_recruit_id: state.recruitDocument.public_recruit_id,
          position: state.recruitDocument.position,
          template_id: templateId
        }
      }

      commit('SET_LOADING', true)

      return (
        coreApiClient
          .post(Evaluation.routes.evaluationRecruitablesPath, params)
          .then(response => {
            commit('ADD_EVALUATION', response.data)
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
          .finally(() => commit('SET_LOADING', false))
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
            commit('SET_EVALUATION', response.data)

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
            commit('SET_EVALUATION', response.data)

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
    removeEvaluation({ state, commit }) {
      const { evaluation } = state;

      coreApiClient
        .delete(Evaluation.routes.evaluationRecruitablePath(evaluation.id))
        .then(() => {
          commit('REMOVE_EVALUATION', evaluation.id)

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
