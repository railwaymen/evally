import axios from 'axios'

const AuthStore = {
  namespaced: true,
  state: {
    user: JSON.parse(localStorage.getItem('current_user')) || null,
    token: localStorage.getItem('user_token') || '',
    status: ''
  },
  getters: {
    isAuthenticated: state => !!state.token,
    status: state => state.status,
    user: state => state.user
  },
  mutations: {
    authRequest: state => {
      state.status = 'loading'
    },
    authSuccess: (state, session) => {
      state.status = 'authenticated'
      state.token = session.jwt
      state.user = session.user.data.attributes
    },
    authError: state => {
      state.status = 'unauthorized'
    },
    authLogout: state => {
      state.status = 'logged_out'
      state.token = ''
      state.user = null
    }
  },
  actions: {
    logIn: (context, payload) => {
      return new Promise((resolve, reject) => {
        context.commit('authRequest')

        axios.post('v1/session', payload)
          .then(response => {
            let session = response.data.session

            localStorage.setItem('user_token', session.jwt)
            localStorage.setItem('current_user', JSON.stringify(session.user.data.attributes))
            context.commit('authSuccess', session)

            resolve()
          })
          .catch(error => {
            localStorage.clear()
            context.commit('authError')

            reject(error)
          })
      })
    },
    logOut: context => {
      return new Promise((resolve, reject) => {
        localStorage.clear()
        delete axios.defaults.headers.common['Authorization']
        context.commit('authLogout')

        resolve()
      })
    }
  }
}

export default AuthStore
