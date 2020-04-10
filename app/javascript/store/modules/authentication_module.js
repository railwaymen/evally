import { coreApiClient } from '@utils/api_clients'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { User } from '@models/user'
import { Setting } from '@models/setting'

const initialState = () => ({
  user: new User(),
  setting: new Setting(),
  loading: false
})

const AuthenticationModule = {
  namespaced: true,

  state: initialState(),

  getters: {
    user: state => state.user,
    setting: state => state.setting,
    loading: state => state.loading
  },

  mutations: {
    setLoading(state, status) {
      state.loading = status
    },
    setSetting(state, setting) {
      state.setting = new Setting(setting)
    },
    setSession(state, { user, setting }) {
      state.user = new User(user)
      state.setting = new Setting(setting)
    },
    setToken(_state, jwt) {
      localStorage.setItem('ev411y_t0k3n', jwt)
    },
    setUser(state, user) {
      state.user = new User(user)
    },
    resetState(state) {
      localStorage.removeItem('ev411y_t0k3n')
      Object.assign(state, initialState())
    },
    clearStore() {
      const modules = [
        'Employees',
        'EmployeesOverview',
        'EmployeesSearch',
        'EvaluationEmployables',
        'Authentication',
        'Templates',
        'RecruitDocuments'
      ]

      modules.forEach(module => this.commit(`${module}Module/resetState`))
    }
  },

  actions: {
    acceptInvitation({ commit }, data) {
      return (
        coreApiClient
          .put(User.routes.invitationPath(data.invitationToken), { invitation: data.invitation })
          .then(() => {
            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.session.acceptInvitation.ok') },
              { root: true }
            )

            return Promise.resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.session.acceptInvitation.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    },
    forgotPassword({ commit }, email) {
      return (
        coreApiClient
          .post(User.routes.passwordsPath, { password: { email } })
          .then(() => {
            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.session.forgotPassword.ok') },
              { root: true }
            )

            return Promise.resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.session.forgotPassword.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    },
    resetPassword({ commit }, data) {
      return (
        coreApiClient
          .put(User.routes.passwordPath(data.resetPasswordToken), { password: data.reset })
          .then(() => {
            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.session.resetPassword.ok') },
              { root: true }
            )

            return Promise.resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.session.resetPassword.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    },
    show({ commit }) {
      commit('setLoading', true)

      return (
        coreApiClient
          .get(User.routes.profilePath)
          .then(response => {
            const { data } = response

            localStorage.setItem('ev411y_l4ng', data.setting.lang || 'en')
            commit('setSession', data)

            return Promise.resolve(data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.session.show.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
          .finally(() => commit('setLoading', false))
      )
    },
    create({ commit }, credentials) {
      return (
        coreApiClient
          .post(User.routes.sessionPath, { session: credentials })
          .then(response => {
            commit('setToken', response.data.jwt)
            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.session.create.ok') },
              { root: true }
            )

            return Promise.resolve()
          })
          .catch(() => {
            commit('resetState')
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.session.create.error') },
              { root: true }
            )

            return Promise.reject()
          })
      )
    },
    updateSetting({ commit }, setting) {
      return (
        coreApiClient
          .put(Setting.routes.settingsPath, { setting })
          .then(response => {
            const { data } = response

            localStorage.setItem('ev411y_l4ng', data.lang || 'en')
            commit('setSetting', data)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.session.updateSetting.ok') },
              { root: true }
            )

            return Promise.resolve(data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.session.updateSetting.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
        )
    },
    updateUser({ commit }, user) {
      coreApiClient
        .put(User.routes.profilePath, { profile: user })
        .then(response => {
          commit('setUser', response.data)

          commit(
            'NotificationsModule/push',
            { success: i18n.t('messages.session.updateUser.ok') },
            { root: true }
          )
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.session.updateUser.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
    },
    updatePassword({ commit }, passwords) {
      return (
        coreApiClient
          .put(User.routes.profilePasswordPath, { profile: passwords })
          .then(() => {
            commit('resetState')

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.session.updatePassword.ok') },
              { root: true }
            )

            return Promise.resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.session.updatePassword.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    },
    destroy({ commit }) {
      commit('clearStore')
      commit('resetState')

      commit(
        'NotificationsModule/push',
        { success: i18n.t('messages.session.destroy.ok') },
        { root: true }
      )

      return Promise.resolve()
    }
  }
}

export default AuthenticationModule
