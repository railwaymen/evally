import http from '@utils/http'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { Recruitment, RecruitmentsList } from '@models/recruitment'

const initialState = () => ({
  recruitments: new RecruitmentsList(),
  recruitment: new Recruitment(),
  loading: true
})

const RecruitmentsModule = {
  namespaced: true,

  state: initialState(),

  getters: {
    recruitments: state => state.recruitments,
    recruitment: state => state.recruitment,
    loading: state => state.loading
  },

  mutations:{
    setLoading(state, status) {
      state.loading = status
      return state
    },
    setList(state, { recruitments }) {
      state.recruitments = new RecruitmentsList(recruitments)
      state.loading = false
      return state
    },
    setItem(state, { recruitment }) {
      state.recruitment = new Recruitment(recruitment)
      state.loading = false
      return state
    },
    resetState(state) {
      state = Object.assign(state, initialState())
      return state
    }
  },

  actions: {
    index({ commit }) {
      commit('setLoading', true)

      http.get(Recruitment.routes.recruitmentsPath)
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

      http.get(Recruitment.routes.recruitmentPath(id))
        .then(response => {
          commit('setItem', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.recruitment.show.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
    },
  }
}

export default RecruitmentsModule
