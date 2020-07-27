import { recruitableApiClient } from '@utils/api_clients'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { InboundEmail, InboundEmailsList } from '@models/inbound_email'

const initialState = () => ({
  inboundEmails: new InboundEmailsList(),
  loading: false
})

const RecruitmentsInboxModule = {
  namespaced: true,

  state: initialState(),

  mutations: {
    SET_DATA(state, data) {
      state.inboundEmails = new InboundEmailsList(data)
    },
    SET_LOADING(state, status) {
      state.loading = status
    },
    RESET_STATE(state) {
      Object.assign(state, initialState())
    }
  },

  actions: {
    fetchData({ commit }) {
      commit('SET_LOADING', true)

      recruitableApiClient
        .get(InboundEmail.routes.inboundEmailsPath)
        .then(response => {
          commit('SET_DATA', response.data)
        })
        .catch((error) => {
          commit(
            'MessagesModule/PUSH_MESSAGE',
            { error: i18n.t('messages.recruitments.inbox.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', false))
    }
  }
}

export default RecruitmentsInboxModule
