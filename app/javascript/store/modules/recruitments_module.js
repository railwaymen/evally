import http from '@utils/http'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { RecruitmentsList } from '@models/recruitment'

const initialState = () => ({
  recruitments: new RecruitmentsList(),
  loading: true
})

const RecruitmentsModule = {
  namespaced: true,
  state: initialState(),
  getters: {
    recruitment: state => state.recruitments,
    loading: state => state.loading
  },
  actions: {
    index({ commit }) {
      commit('setLoading', true)

      http.get(Recruitment.routesr.RecruitmentsPath)
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

export default RecruitmentsModule
