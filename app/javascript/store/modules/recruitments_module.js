import { recruitableApiClient } from '@utils/api_clients'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { Recruitment, RecruitmentsList } from '@models/recruitment'
import { UsersList } from '@models/user'

const initState = () => ({
  recruitments: new RecruitmentsList(),
  users: new UsersList(),
  loading: true
})

const RecruitmentsModule = {
  namespaced: true,

  state: initState(),

  getters: {},

  mutations: {
    ADD_RECRUITMENT(state, recruitment) {
      state.recruitments.unshift(recruitment)
    },
    SET_LOADING(state, status) {
      state.loading = status
    },
    SET_DATA(state, { recruitments, users }) {
      state.recruitments = new RecruitmentsList(recruitments)
      state.users = new UsersList(users)
      state.loading = false
    },
    REFRESH_RECRUITMENT(state, recruitment) {
      state.recruitments.refresh(recruitment)
    },
    REMOVE_RECRUITMENT(state, id) {
      state.recruitments.dropById(id)
    },
    RESET_STATE(state) {
      Object.assign(state, initState())
    },
  },

  actions: {
    fetchRecruitments({ commit }) {
      commit('SET_LOADING', true)

      recruitableApiClient
        .get(Recruitment.routes.recruitmentsPath)
        .then(response => {
          commit('SET_DATA', response.data)
        })
        .catch(error => {
          commit(
            'MessagesModule/PUSH_MESSAGE',
            { error: i18n.t('messages.recruitments.projects.index.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', false))
    },
    createRecruitment({ commit }, recruitment) {
      return new Promise(resolve => {
        recruitableApiClient
          .post(Recruitment.routes.recruitmentsPath, { recruitment })
          .then(response => {
            commit('ADD_RECRUITMENT', response.data)

            commit(
              'MessagesModule/PUSH_MESSAGE',
              { success: i18n.t('messages.recruitments.projects.create.ok') },
              { root: true }
            )

            resolve(response.data)
          })
          .catch(error => {
            commit(
              'MessagesModule/PUSH_MESSAGE',
              { error: i18n.t('messages.recruitments.projects.create.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    startRecruitment({ commit }, recruitment) {
      return new Promise(resolve => {
        recruitableApiClient
          .put(Recruitment.routes.startRecruitmentPath(recruitment.id))
          .then(response => {
            commit('REFRESH_RECRUITMENT', response.data)

            commit(
              'MessagesModule/PUSH_MESSAGE',
              { success: i18n.t('messages.recruitments.projects.start.ok') },
              { root: true }
            )

            resolve(response.data)
          })
          .catch(error => {
            commit(
              'MessagesModule/PUSH_MESSAGE',
              { error: i18n.t('messages.recruitments.projects.start.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    completeRecruitment({ commit }, recruitment) {
      return new Promise(resolve => {
        recruitableApiClient
          .put(Recruitment.routes.completeRecruitmentPath(recruitment.id))
          .then(response => {
            commit('REFRESH_RECRUITMENT', response.data)

            commit(
              'MessagesModule/PUSH_MESSAGE',
              { success: i18n.t('messages.recruitments.projects.complete.ok') },
              { root: true }
            )

            resolve(response.data)
          })
          .catch(error => {
            commit(
              'MessagesModule/PUSH_MESSAGE',
              { error: i18n.t('messages.recruitments.projects.complete.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    updateRecruitment({ commit }, recruitment) {
      return new Promise(resolve => {
        recruitableApiClient
          .put(Recruitment.routes.recruitmentPath(recruitment.id), { recruitment })
          .then(response => {
            commit('REFRESH_RECRUITMENT', response.data)

            commit(
              'MessagesModule/PUSH_MESSAGE',
              { success: i18n.t('messages.recruitments.projects.update.ok') },
              { root: true }
            )

            resolve(response.data)
          })
          .catch(error => {
            commit(
              'MessagesModule/PUSH_MESSAGE',
              { error: i18n.t('messages.recruitments.projects.update.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    addRecruitmentStage({ commit }, { recruitment, stage }) {
      return new Promise(resolve => {
        recruitableApiClient
          .put(Recruitment.routes.addRecruitmentStagePath(recruitment.id), { stage })
          .then(response => {
            commit('REFRESH_RECRUITMENT', response.data)

            commit(
              'MessagesModule/PUSH_MESSAGE',
              { success: i18n.t('messages.recruitments.addStage.ok') },
              { root: true }
            )

            resolve(response.data)
          })
          .catch(error => {
            commit(
              'MessagesModule/PUSH_MESSAGE',
              { error: i18n.t('messages.recruitments.addStage.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    dropRecruitmentStage({ commit }, { recruitment, stage }) {
      return new Promise(resolve => {
        recruitableApiClient
          .put(Recruitment.routes.dropRecruitmentStagePath(recruitment.id), { stage })
          .then(response => {
            commit('REFRESH_RECRUITMENT', response.data)

            commit(
              'MessagesModule/PUSH_MESSAGE',
              { success: i18n.t('messages.recruitments.dropStage.ok') },
              { root: true }
            )

            resolve(response.data)
          })
          .catch(error => {
            commit(
              'MessagesModule/PUSH_MESSAGE',
              { error: i18n.t('messages.recruitments.dropStage.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    removeRecruitment({ commit }, recruitment) {
      return new Promise(resolve => {
        recruitableApiClient
          .delete(Recruitment.routes.recruitmentPath(recruitment.id))
          .then(() => {
            commit('REMOVE_RECRUITMENT', recruitment.id)

            commit(
              'MessagesModule/PUSH_MESSAGE',
              { success: i18n.t('messages.recruitments.projects.delete.ok') },
              { root: true }
            )

            resolve()
          })
          .catch(error => {
            commit(
              'MessagesModule/PUSH_MESSAGE',
              { error: i18n.t('messages.recruitments.projects.delete.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
  }
}

export default RecruitmentsModule
