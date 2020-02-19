import http from '@utils/http'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { User } from '@models/user'
import { Setting } from '@models/setting'

const initialState = () => ({
  user: new User(),
  setting: new Setting(),
  loading: false
})

const SessionModule = {
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
      return state
    },
    setSetting(state, setting) {
      state.setting = new Setting(setting)
      return state
    },
    setSession(state, { user, setting }) {
      state.user = new User(user)
      state.setting = new Setting(setting)
      return state
    },
    setToken(state, jwt) {
      localStorage.setItem('ev411y_t0k3n', jwt)
      return state
    },
    setUser(state, user) {
      state.user = new User(user)
      return state
    },
    resetState(state) {
      localStorage.removeItem('ev411y_t0k3n')

      state = Object.assign(state, initialState())
      return state
    },
    clearStore() {
      const modules = [
        'Drafts',
        'Employees',
        'EmployeesOverview',
        'EmployeesSearch',
        'Session',
        'Templates'
      ]

      modules.forEach(module => this.commit(`${module}Module/resetState`))
    }
  },

  actions: {
    acceptInvitation({ commit }, data) {
      return new Promise((resolve) => {
        http.put(User.routes.invitationPath(data.invitationToken), { invitation: data.invitation })
          .then(response => {
            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.session.acceptInvitation.ok') },
              { root: true }
            )

            resolve(response)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.session.acceptInvitation.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    forgotPassword({ commit }, email) {
      return new Promise((resolve) => {
        http.post(User.routes.passwordsPath, { password: { email } })
          .then(response => {
            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.session.forgotPassword.ok') },
              { root: true }
            )

            resolve(response)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.session.forgotPassword.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    resetPassword({ commit }, data) {
      return new Promise((resolve) => {
        http.put(User.routes.passwordPath(data.resetPasswordToken), { password: data.reset })
          .then(response => {
            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.session.resetPassword.ok') },
              { root: true }
            )

            resolve(response)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.session.resetPassword.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    show({ commit }) {
      commit('setLoading', true)

      return new Promise((resolve) => {
        http.get(User.routes.profilePath)
          .then(response => {
            const { data } = response

            localStorage.setItem('ev411y_l4ng', data.setting.lang || 'en')
            commit('setSession', data)

            resolve(data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.session.show.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
          .finally(() => commit('setLoading', false))
      })
    },
    create({ commit }, credentials) {
      return new Promise((resolve, reject) => {
        http.post(User.routes.sessionPath, { session: credentials })
          .then(response => {
            commit('setToken', response.data.session.jwt)
            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.session.create.ok') },
              { root: true }
            )

            resolve()
          })
          .catch(() => {
            commit('resetState')
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.session.create.error') },
              { root: true }
            )

            reject()
          })
      })
    },
    updateSetting({ commit }, setting) {
      const params = {
        setting: setting.attributes
      }

      return new Promise((resolve) => {
        http.put(Setting.routes.settingsPath, params)
          .then(response => {
            const { data } = response

            localStorage.setItem('ev411y_l4ng', data.lang || 'en')
            commit('setSetting', data)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.session.updateSetting.ok') },
              { root: true }
            )

            resolve(data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.session.updateSetting.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
        })
    },
    updateUser({ commit }, user) {
      const params = {
        profile: user.attributes
      }

      http.put(User.routes.profilePath, params)
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
      const params = { profile: passwords }

      return new Promise((resolve) => {
        http.put(User.routes.profilePasswordPath, params)
          .then(() => {
            delete http.defaults.headers.common['Authorization']

            commit('resetState')
            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.session.updatePassword.ok') },
              { root: true }
            )

            resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.session.updatePassword.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    destroy({ commit }) {
      return new Promise((resolve) => {
        delete http.defaults.headers.common['Authorization']

        // context.commit('clearStore')
        commit('resetState')
        commit(
          'NotificationsModule/push',
          { success: i18n.t('messages.session.destroy.ok') },
          { root: true }
        )

        resolve()
      })
    }
  }
}

export default SessionModule
