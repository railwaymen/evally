import http from '@/lib/http_config'

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
    resetState(state) {
      localStorage.removeItem('ev411y_t0k3n')

      state = Object.assign(state, initialState())
      return state
    }
  },

  actions: {
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
          .catch(() => {
            commit(
              'FlashStore/push',
              { error: 'Problem with fetching user' },
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
              'FlashStore/push',
              { success: 'You have been logged in succesfully' },
              { root: true }
            )

            resolve()
          })
          .catch(() => {
            commit('resetState')
            commit(
              'FlashStore/push',
              { error: 'Invalid credentials, please try again' },
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
              'FlashStore/push',
              { success: 'Settings have been updated' },
              { root: true }
            )

            resolve(data)
          })
          .catch(() => {
            commit(
              'FlashStore/push',
              { error: 'Error :(' },
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
          'FlashStore/push',
          { success: 'You have been logged out succesfully' },
          { root: true }
        )

        resolve()
      })
    }
  }
}

export default SessionModule
