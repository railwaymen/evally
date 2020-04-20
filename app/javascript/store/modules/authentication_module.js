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

  mutations: {
    SET_LOADING(state, status) {
      state.loading = status
    },
    SET_SETTING(state, setting) {
      state.setting = new Setting(setting)

      localStorage.setItem('ev411y_l4ng', setting.lang || 'en')
    },
    SET_SESSION(state, { user, setting }) {
      state.user = new User(user)
      state.setting = new Setting(setting)

      localStorage.setItem('ev411y_l4ng', setting.lang || 'en')
    },
    SAVE_TOKEN(_state, jwt) {
      localStorage.setItem('ev411y_t0k3n', jwt)
    },
    SET_USER(state, user) {
      state.user = new User(user)
    },
    RESET_STORE(state) {
      localStorage.removeItem('ev411y_t0k3n')
      Object.assign(state, initialState())

      const modules = [
        'Employees',
        'EmployeesOverview',
        'EmployeesSearch',
        'EvaluationEmployables',
        'Templates',
        'RecruitDocuments'
      ]

      modules.forEach(module => this.commit(`${module}Module/RESET_STATE`))
    }
  },

  actions: {
    acceptInvitation({ commit }, data) {
      return new Promise(resolve => {
        coreApiClient
          .put(User.routes.invitationPath(data.invitationToken), { invitation: data.invitation })
          .then(() => {
            commit(
              'NotificationsModule/PUSH_NOTIFICATION',
              { success: i18n.t('messages.session.acceptInvitation.ok') },
              { root: true }
            )

            resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/PUSH_NOTIFICATION',
              { error: i18n.t('messages.session.acceptInvitation.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    forgotPassword({ commit }, email) {
      return new Promise(resolve => {
        coreApiClient
          .post(User.routes.passwordsPath, { password: { email } })
          .then(() => {
            commit(
              'NotificationsModule/PUSH_NOTIFICATION',
              { success: i18n.t('messages.session.forgotPassword.ok') },
              { root: true }
            )

            resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/PUSH_NOTIFICATION',
              { error: i18n.t('messages.session.forgotPassword.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    resetPassword({ commit }, data) {
      return new Promise(resolve => {
        coreApiClient
          .put(User.routes.passwordPath(data.resetPasswordToken), { password: data.reset })
          .then(() => {
            commit(
              'NotificationsModule/PUSH_NOTIFICATION',
              { success: i18n.t('messages.session.resetPassword.ok') },
              { root: true }
            )

            resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/PUSH_NOTIFICATION',
              { error: i18n.t('messages.session.resetPassword.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    fetchSession({ commit }) {
      commit('SET_LOADING', true)

      return new Promise(resolve => {
        coreApiClient
          .get(User.routes.profilePath)
          .then(response => {
            commit('SET_SESSION', response.data)

            resolve(response.data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/PUSH_NOTIFICATION',
              { error: i18n.t('messages.session.show.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
          .finally(() => commit('SET_LOADING', false))
      })
    },
    login({ commit }, credentials) {
      return new Promise((resolve, reject) => {
        coreApiClient
          .post(User.routes.sessionPath, { session: credentials })
          .then(response => {
            commit('SAVE_TOKEN', response.data.jwt)
            commit(
              'NotificationsModule/PUSH_NOTIFICATION',
              { success: i18n.t('messages.session.create.ok') },
              { root: true }
            )

            resolve()
          })
          .catch(() => {
            commit('RESET_STORE')
            commit(
              'NotificationsModule/PUSH_NOTIFICATION',
              { error: i18n.t('messages.session.create.error') },
              { root: true }
            )

            reject()
          })
      })
    },
    updateSetting({ commit }, setting) {
      return new Promise(resolve => {
        coreApiClient
          .put(Setting.routes.settingsPath, { setting })
          .then(response => {
            commit('SET_SETTING', response.data)
            commit(
              'NotificationsModule/PUSH_NOTIFICATION',
              { success: i18n.t('messages.session.updateSetting.ok') },
              { root: true }
            )

            resolve(response.data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/PUSH_NOTIFICATION',
              { error: i18n.t('messages.session.updateSetting.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    updateUser({ commit }, user) {
      coreApiClient
        .put(User.routes.profilePath, { profile: user })
        .then(response => {
          commit('SET_USER', response.data)

          commit(
            'NotificationsModule/PUSH_NOTIFICATION',
            { success: i18n.t('messages.session.updateUser.ok') },
            { root: true }
          )
        })
        .catch(error => {
          commit(
            'NotificationsModule/PUSH_NOTIFICATION',
            { error: i18n.t('messages.session.updateUser.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
    },
    updatePassword({ commit }, passwords) {
      return new Promise(resolve => {
        coreApiClient
          .put(User.routes.profilePasswordPath, { profile: passwords })
          .then(() => {
            commit('RESET_STORE')
            commit(
              'NotificationsModule/PUSH_NOTIFICATION',
              { success: i18n.t('messages.session.updatePassword.ok') },
              { root: true }
            )

            resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/PUSH_NOTIFICATION',
              { error: i18n.t('messages.session.updatePassword.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    logout({ commit }) {
      commit('RESET_STORE')
      commit(
        'NotificationsModule/PUSH_NOTIFICATION',
        { success: i18n.t('messages.session.destroy.ok') },
        { root: true }
      )

      return Promise.resolve()
    }
  }
}

export default AuthenticationModule
