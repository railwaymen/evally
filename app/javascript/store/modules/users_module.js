import { coreApiClient } from '@utils/api_clients'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { User, UsersList } from '@models/user'

const initState = () => ({
  users: new UsersList(),
  user: new User(),
  loading: true
})

const UsersModule = {
  namespaced: true,

  state: initState(),

  mutations: {
    ADD_USER(state, user) {
      state.users.unshift(user)
    },
    REFRESH_USER(state, user) {
      state.users.refresh(user)
    },
    RESET_STATE(state) {
      Object.assign(state, initState())
    },
    SET_LOADING(state, status) {
      state.loading = status
    },
    SET_USERS(state, users) {
      state.users = new UsersList(users)
      state.loading = false
    }
  },

  actions: {
    fetchUsers({ commit }) {
      commit('SET_LOADING', true)

      coreApiClient
        .get(User.routes.usersPath)
        .then(response => {
          commit('SET_USERS', response.data)
        })
        .catch(error => {
          commit(
            'MessagesModule/PUSH_MESSAGE',
            { error: i18n.t('messages.users.index.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', false))
    },
    createUser({ commit }, user) {
      return new Promise(resolve => {
        coreApiClient
          .post(User.routes.invitationsPath, { invitation: user })
          .then(response => {
            commit('ADD_USER', response.data)

            commit(
              'MessagesModule/PUSH_MESSAGE',
              { success: i18n.t('messages.users.create.ok') },
              { root: true }
            )

            resolve(response.data)
          })
          .catch(error => {
            commit(
              'MessagesModule/PUSH_MESSAGE',
              { error: i18n.t('messages.users.create.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    updateUser({ commit }, user) {
      return new Promise(resolve => {
        coreApiClient
          .put(User.routes.userPath(user.id), { user })
          .then(response => {
            commit('REFRESH_USER', response.data)

            commit(
              'MessagesModule/PUSH_MESSAGE',
              { success: i18n.t('messages.users.update.ok') },
              { root: true }
            )

            resolve(response.data)
          })
          .catch(error => {
            commit(
              'MessagesModule/PUSH_MESSAGE',
              { error: i18n.t('messages.users.update.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    }
  }
}

export default UsersModule
