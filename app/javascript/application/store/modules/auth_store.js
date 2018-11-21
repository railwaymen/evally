import axios from 'axios'

import { Utils } from '@/lib/utils'

import { Setting } from '@/models/setting'
import { User } from '@/models/user'

const AuthStore = {
  namespaced: true,

  state: {
    user: new User(),
    setting: new Setting(),
    status: ''
  },

  getters: {
    user: state => state.user,
    setting: state => state.setting,
    status: state => state.status
  },

  mutations: {
    setSession(state, data) {
      state.user = new User(data.user)
      state.setting = new Setting(data.setting)
      state.status = 'signedIn'
      return state
    },
    clearSession(state) {
      state.user = new User()
      state.setting = new Setting()
      state.status = 'signedOut'
      return state
    },
    progress(state, status) {
      state.status = status
      return state
    }
  },

  actions: {
    logIn(context, credentials) {
      return new Promise((resolve, reject) => {
        context.commit('progress', 'loading')

        axios.post('v1/session', credentials)
          .then(response => {
            let session = Utils.prepareSession(response.data)

            localStorage.setItem('ev411y_t0k3n', response.data.session.jwt)
            localStorage.setItem('ev411y_s3ssi0n', JSON.stringify(session))
            context.commit('setSession', session)

            resolve()
          })
          .catch(error => {
            localStorage.clear()
            context.commit('progress', 'error')

            reject(error)
          })
      })
    },

    logOut(context) {
      return new Promise((resolve, reject) => {
        localStorage.clear()

        delete axios.defaults.headers.common['Authorization']
        context.commit('clearSession')

        resolve()
      })
    }
  }
}

export default AuthStore
