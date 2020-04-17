import { coreApiClient } from '@utils/api_clients'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { User, UsersList } from '@models/user'

const initialState = () => ({
  users: new UsersList(),
  user: new User(),
  loading: true
})

const UsersModule = {
  namespaced: true,

  state: initialState(),

  getters: {
    users: state => state.users,
    user: state => state.user,
    loading: state => state.loading
  },

  mutations: {
    addToList(state, data) {
      state.users.unshift(data)
    },
    refreshListItem(state, data) {
      state.users.refresh(data)
    },
    setItem(state, user) {
      state.user = new User(user)
    },
    setList(state, users) {
      state.users = new UsersList(users)
      state.loading = false
    },
    setLoading(state, status) {
      state.loading = status
    },
    RESET_STATE(state) {
      Object.assign(state, initialState())
    }
  },

  actions: {
    index({ commit }) {
      commit('setLoading', true)

      coreApiClient
        .get(User.routes.usersPath)
        .then(response => {
          commit('setList', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.users.index.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('setLoading', false))
    },
    create({ commit }, user) {
      return (
        coreApiClient
          .post(User.routes.invitationsPath, { invitation: user })
          .then(response => {
            commit('addToList', response.data)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.users.create.ok') },
              { root: true }
            )

            return Promise.resolve(response.data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.users.create.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    },
    update({ commit }, user) {
      return (
        coreApiClient
          .put(User.routes.userPath(user.id), { user })
          .then(response => {
            commit('refreshListItem', response.data)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.users.update.ok') },
              { root: true }
            )

            return Promise.resolve(response.data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.users.update.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    }
  }
}

export default UsersModule
