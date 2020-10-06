import { coreApiClient } from '@utils/api_clients'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import EmailTemplatePolicy from '@policies/email_template_policy'

import { EmailTemplate, EmailTemplatesList } from '@models/email_template'

const initState = () => ({
  emailTemplates: new EmailTemplatesList(),
  emailTemplate: new EmailTemplate(),
  loading: true
})

const EmailTemplatesModule = {
  namespaced: true,

  state: initState(),

  getters: {
    emailTemplatePolicy: (state, _getters, rootState) => (
      new EmailTemplatePolicy(rootState.AuthenticationModule.user, state.emailTemplate)
    )
  },

  mutations: {
    ADD_TEMPLATE(state, email_template) {
      state.emailTemplates.unshift(email_template)
      state.emailTemplate.assign({ ...email_template, editable: false })
    },
    REFRESH_TEMPLATE(state, email_template) {
      state.emailTemplates.refresh(email_template)
      state.emailTemplate.assign(email_template)
    },
    REMOVE_TEMPLATE(state, id) {
      state.emailTemplate = new EmailTemplate()
      state.emailTemplates.dropById(id)
    },
    RESET_STATE(state) {
      Object.assign(state, initState())
    },
    SET_EDITABLE(state) {
      state.emailTemplate.editable = true
    },
    SET_LOADING(state, status) {
      state.loading = status
    },
    SET_TEMPLATE(state, email_template) {
      state.emailTemplate = new EmailTemplate(email_template)
    },
    SET_TEMPLATES(state, email_templates) {
      state.emailTemplates = new EmailTemplatesList(email_templates)
      state.loading = false
    }
  },

  actions: {
    fetchTemplates({ commit }) {
      commit('SET_LOADING', true)

      coreApiClient
        .get(EmailTemplate.routes.templatesPath)
        .then(response => {
          commit('SET_TEMPLATES', response.data)
        })
        .catch(error => {
          commit(
            'MessagesModule/PUSH_MESSAGE',
            { error: i18n.t('messages.emailTemplates.index.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', false))
    },
    fetchTemplate({ commit }, id) {
      if (id === 'new') {
        commit('SET_TEMPLATE', { editable: true })

        return
      }

      coreApiClient
        .get(EmailTemplate.routes.templatePath(id))
        .then(response => {
          commit('SET_TEMPLATE', response.data)
        })
        .catch(error => {
          commit(
            'MessagesModule/PUSH_MESSAGE',
            { error: i18n.t('messages.emailTemplates.show.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
    },
    createTemplate({ state, commit }) {
      const params = {
        email_template: state.emailTemplate
      }

      return new Promise(resolve => {
        coreApiClient
          .post(EmailTemplate.routes.templatesPath, params)
          .then(response => {
            commit('ADD_TEMPLATE', response.data)
            commit(
              'MessagesModule/PUSH_MESSAGE',
              { success: i18n.t('messages.emailTemplates.create.ok') },
              { root: true }
            )

            resolve(response.data)
          })
          .catch(error => {
            commit(
              'MessagesModule/PUSH_MESSAGE',
              { error: i18n.t('messages.emailTemplates.create.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    updateTemplate({ state, commit }) {
      const { emailTemplate } = state

      const params = {
        email_template: emailTemplate
      }

      return new Promise(resolve => {
        coreApiClient
          .put(EmailTemplate.routes.templatePath(emailTemplate.id), params)
          .then(response => {
            commit('REFRESH_TEMPLATE', { ...response.data, editable: false })

            commit(
              'MessagesModule/PUSH_MESSAGE',
              { success: i18n.t('messages.emailTemplates.update.ok') },
              { root: true }
            )

            resolve(response.data)
          })
          .catch(error => {
            commit(
              'MessagesModule/PUSH_MESSAGE',
              { error: i18n.t('messages.emailTemplates.update.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    removeTemplate({ state, commit }) {
      const { emailTemplate } = state

      return new Promise(resolve => {
        coreApiClient
          .delete(EmailTemplate.routes.templatePath(emailTemplate.id))
          .then(() => {
            commit('REMOVE_TEMPLATE', emailTemplate.id)

            commit(
              'MessagesModule/PUSH_MESSAGE',
              { success: i18n.t('messages.emailTemplates.delete.ok') },
              { root: true }
            )

            resolve()
          })
          .catch(error => {
            commit(
              'MessagesModule/PUSH_MESSAGE',
              { error: i18n.t('messages.emailTemplates.delete.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    }
  }
}

export default EmailTemplatesModule
