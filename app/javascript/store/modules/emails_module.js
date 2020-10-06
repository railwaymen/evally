import axios from 'axios'

import { coreApiClient, recruitableApiClient } from '@utils/api_clients'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { EmailTemplatesList } from '@models/email_template'
import { RecruitDocument } from '@models/recruit_document'
import { Email } from '@models/email'
import { User } from '@models/user'

const initState = () => ({
  emailTemplates: new EmailTemplatesList(),
  recruitDocument: new RecruitDocument(),
  user: new User(),
  loading: 'fetch'
})

const EmailsModule = {
  namespaced: true,

  state: initState(),

  getters: {
    fetchLoading: state => state.loading === 'fetch',
    sendLoading: state => state.loading === 'send'
  },

  mutations: {
    SET_FORM_DATA(state, { email_templates, user }) {
      state.emailTemplates = new EmailTemplatesList(email_templates)
      state.user = new User(user)
    },
    SET_LOADING(state, status) {
      state.loading = status
    },
    SET_RECRUIT_DOCUMENT(state, recruit_document) {
      state.recruitDocument = new RecruitDocument(recruit_document)
    }
  },

  actions: {
    fetchData({ commit }, id) {
      commit('SET_LOADING', 'fetch')

      axios
        .all([
          recruitableApiClient.get(RecruitDocument.routes.mailerPath(id)),
          coreApiClient.get(Email.routes.emailsFormPath)
        ])
        .then(axios.spread((recruitableApiResponse, coreApiResponse) => {
          commit('SET_RECRUIT_DOCUMENT', recruitableApiResponse.data)
          commit('SET_FORM_DATA', coreApiResponse.data)
        }))
        .catch(error => {
          commit(
            'MessagesModule/PUSH_MESSAGE',
            { error: i18n.t('messages.emails.form.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', 'ok'))
    },
    send({ commit }, email) {
      commit('SET_LOADING', 'send')

      return new Promise(resolve => {
        coreApiClient
          .post(Email.routes.emailsPath, { email })
          .then(() => {
            commit(
              'MessagesModule/PUSH_MESSAGE',
              { success: i18n.t('messages.emails.send.ok', { recipient: email.to }) },
              { root: true }
            )

            resolve()
          })
          .catch(error => {
            commit(
              'MessagesModule/PUSH_MESSAGE',
              { error: i18n.t('messages.emails.send.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
          .finally(() => commit('SET_LOADING', 'ok'))
      })
    }
  }
}

export default EmailsModule
