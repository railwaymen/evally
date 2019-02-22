import axios from 'axios'

import { Utils } from '@/lib/utils'

import { Setting } from '@/models/setting'
import { User } from '@/models/user'

const initialState = () => ({
  user: new User(),
  setting: new Setting(),
  status: ''
})

const AuthStore = {
  namespaced: true,

  state: initialState(),

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
    progress(state, status) {
      state.status = status
      return state
    },
    updateSetting(state, data) {
      state.setting = new Setting(data)
      return state
    },
    resetState(state) {
      state = Object.assign(state, initialState())
      return state
    },

    clearStore(state) {
      let modules = ['Activities', 'Auth', 'Browser', 'Employees', 'Evaluations', 'Sections', 'Templates']
      modules.forEach(module => this.commit(`${module}Store/resetState`))
    }
  },

  actions: {
    logIn(context, credentials) {
      return new Promise((resolve, reject) => {
        context.commit('progress', 'loading')

        axios.post('v1/session', credentials)
          .then(response => {
            localStorage.setItem('ev411y_t0k3n', response.data.session.jwt)
            resolve()
          })
          .catch(error => {
            localStorage.removeItem('ev411y_t0k3n')
            context.commit('progress', 'error')

            reject(error)
          })
      })
    },

    logOut(context) {
      return new Promise((resolve, reject) => {
        localStorage.removeItem('ev411y_t0k3n')

        delete axios.defaults.headers.common['Authorization']
        context.commit('clearStore')

        resolve()
      })
    },

    getUser(context) {
      return new Promise((resolve, reject) => {
        axios.get('v1/users/current')
          .then(response => {
            let session = Utils.prepareSession(response.data)

            localStorage.setItem('ev411y_l4ng', session.setting.lang || 'en')
            context.commit('setSession', session)

            resolve(session)
          })
          .catch(error => {
            reject(error)
          })
      })
    },

    updateUser(context, data) {
      return new Promise((resolve, reject) => {
        axios.put('v1/users/current', data)
          .then(response => {
            let user = new User(response.data)

            context.commit('updateSetting', user.setting)

            resolve(response)
          })
          .catch(error => {
            reject(error)
          })
      })
    },

    updatePassword(context, data) {
      return new Promise((resolve, reject) => {
        axios.put('v1/users/current/password', data)
          .then(() => {
            localStorage.removeItem('ev411y_t0k3n')

            delete axios.defaults.headers.common['Authorization']
            context.commit('clearStore')

            resolve()
          })
          .catch(error => {
            reject(error)
          })
      })
    },

    saveSetting(context, data) {
      return new Promise((resolve, reject) => {
        axios.put('v1/settings/current', data)
          .then(response => {
            let user = new User(response.data)

            localStorage.setItem('ev411y_l4ng', user.setting.lang || 'en')
            context.commit('updateSetting', user.setting)

            resolve(user.setting)
          })
          .catch(error => {
            reject(error)
          })
      })
    }
  }
}

export default AuthStore
