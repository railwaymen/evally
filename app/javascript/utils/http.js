import axios from 'axios'

import store from '@store/store'
import router from '@router/router'

// Request interceptor
axios.interceptors.request.use(config => {

  config.baseURL = `${window.location.origin}/${localStorage.getItem('ev411y_l4ng') || 'en'}`

  config.headers.common['Content-Type'] = 'application/json'
  config.headers.common['Accept'] = 'application/json'

  config.headers.common['Token'] = localStorage.getItem('ev411y_t0k3n')
  config.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

  return config;
}, error => {
  return Promise.reject(error);
})

// Response interceptor
axios.interceptors.response.use(response => {
  return response
}, error => {
  switch (error.response.status) {
    case 401:
      store.commit('AuthenticationModule/clearStore')
      localStorage.removeItem('ev411y_t0k3n')

      router.push({ name: 'login_path' })

      break
    case 403:
      router.push({ name: 'dashboard_path' })

      break
    default:
      null
  }

  return Promise.reject(error)
})

export default axios
