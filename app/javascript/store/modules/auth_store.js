import axios from 'axios'

const AuthStore = {
  namespaced: true,
  state: {
    email: localStorage.getItem('user_email') || '',
    token: localStorage.getItem('user_token') || '',
    status: ''
  },
  getters: {
    isAuthenticated: state => !!state.token,
    status: state => state.status
  },
  mutations: {
    authRequest: state => {
      state.status = 'loading'
    },
    authSuccess: (state, token) => {
      state.status = 'authenticated'
      state.token = token
    },
    authError: state => {
      state.status = 'unauthorized'
    },
    authLogout: state => {
      state.status = 'logged_out'
      state.token = ''
    }
  },
  actions: {
    logIn: (context, payload) => {
      return new Promise((resolve, reject) => {
        context.commit('authRequest')

        axios.post('/session', payload)
          .then(response => {
            let token = response.data.session.jwt

            localStorage.setItem('user_token', token)
            context.commit('authSuccess', token)

            resolve()
          })
          .catch(error => {
            localStorage.removeItem('user_token')
            context.commit('authError')

            reject(error)
          })
      })
    },
    logOut: context => {
      return new Promise((resolve, reject) => {
        localStorage.removeItem('user_token')
        delete axios.defaults.headers.common['Authorization']
        context.commit('authLogout')

        resolve()
      })
    }
  }
}

export default AuthStore
