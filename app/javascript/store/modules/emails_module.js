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
  loading: true
})

const EmailsModule = {
  namespaced: true,

  state: initState(),

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
      commit('SET_LOADING', true)

      axios
        .all([
          recruitableApiClient.get(RecruitDocument.routes.mailerPath(id)),
          coreApiClient.get(Email.routes.mailerPath)
        ])
        .then(axios.spread((recruitableApiResponse, coreApiResponse) => {
          commit('SET_RECRUIT_DOCUMENT', recruitableApiResponse.data)
          commit('SET_FORM_DATA', coreApiResponse.data)
        }))
        .catch(error => {
          commit(
            'MessagesModule/PUSH_MESSAGE',
            { error: i18n.t('messages.email.form.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', false))

      // coreApiClient
      //   .get(Email.routes.formDataPath)
      //   .then(response => {
      //     commit('SET_DATA', response.data)
      //   })
      //   .catch(error => {
      //     commit(
      //       'MessagesModule/PUSH_MESSAGE',
      //       { error: i18n.t('messages.email.form.error', { msg: fetchError(error) }) },
      //       { root: true }
      //     )
      //   })
      //   .finally(() => commit('SET_LOADING', false))
    },
  }
}

export default EmailsModule
