import http from '@utils/http'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { CandidatesList } from '@models/candidate'

const initialState = () => ({
  candidates: new CandidatesList(),
  loading: true
})

const CandidatesModule = {
  namespaced: true,
  state: initialState(),
  getters: {
    candidates: state => state.candidates,
    loading: state => state.loading
  },
  actions: {
    index({ commit }) {
      commit('setLoading', true)

      http.get(Candidate.routes.candidatesPath)
        .then(response => {
          commit('setList', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.employees.index.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('setLoading', false))
    }
  }
}

export default CandidatesModule
