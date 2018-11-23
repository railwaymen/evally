import axios from 'axios'

import store from '../store'
import router from '../router'

// Request interceptor
axios.interceptors.request.use(config => {

  config.baseURL = window.location.origin
  config.headers.common['Content-Type'] = 'application/json'

  const token = localStorage.getItem('ev411y_t0k3n')
  if (token) config.headers.common['Authorization'] = 'Bearer ' + token

  config.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

  return config;
}, error => {
  return Promise.reject(error);
})

// Response interceptor
axios.interceptors.response.use(response => {
  return response
}, error => {
  if (error.response.status === 401) {
    store.commit('AuthStore/clearSession')

    router.push({ name: 'landing_page_path' })
    localStorage.clear()
  }

  return Promise.reject(error)
})

export default axios
