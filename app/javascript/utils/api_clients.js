import axios from 'axios'

import store from '@store/store'
import router from '@router/router'

/**
 * Create a new Axios client instance
 * @see https://github.com/mzabriskie/axios#creating-an-instance
 */
const initClient = (baseUrl = null) => {
  const evallyTokenKey = 'ev411y_t0k3n'
  const evallyLangKey = 'ev411y_l4ng'

  const language = localStorage.getItem(evallyLangKey) || 'en'
  const token = localStorage.getItem(evallyTokenKey)

  const options = {
    baseURL: [baseUrl, language].join('/'),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
      'Token': token
    }
  }

  const client = axios.create(options)

  // Add a request interceptor
  client.interceptors.request.use(
    requestConfig => requestConfig,
    (requestError) => {
      // Raven.captureException(requestError)

      return Promise.reject(requestError)
    },
  )

  // Add a response interceptor
  client.interceptors.response.use(
    response => response,
    (error) => {
      switch (error.response.status) {
        case 401:
          store.commit('AuthenticationModule/clearStore')
          localStorage.removeItem(evallyTokenKey)

          router.push({ name: 'login_path' })
          break
        case 403:
          router.push({ name: 'dashboard_path' })
          break
        case 404:
        case 422:
          break
        default:
          // Raven.captureException(error)
      }

      return Promise.reject(error)
    },
  )

  return client
}

class ApiClient {
  constructor(baseUrl = null) {
    this.client = initClient(baseUrl)
  }

  get(url, conf = {}) {
    return this.client.get(url, conf)
      .then(response => Promise.resolve(response))
      .catch(error => Promise.reject(error))
  }

  delete(url, conf = {}) {
    return this.client.delete(url, conf)
      .then(response => Promise.resolve(response))
      .catch(error => Promise.reject(error))
  }

  head(url, conf = {}) {
    return this.client.head(url, conf)
      .then(response => Promise.resolve(response))
      .catch(error => Promise.reject(error))
  }

  options(url, conf = {}) {
    return this.client.options(url, conf)
      .then(response => Promise.resolve(response))
      .catch(error => Promise.reject(error))
  }

  post(url, data = {}, conf = {}) {
    return this.client.post(url, data, conf)
      .then(response => Promise.resolve(response))
      .catch(error => Promise.reject(error))
  }

  put(url, data = {}, conf = {}) {
    return this.client.put(url, data, conf)
      .then(response => Promise.resolve(response))
      .catch(error => Promise.reject(error))
  }

  patch(url, data = {}, conf = {}) {
    return this.client.patch(url, data, conf)
      .then(response => Promise.resolve(response))
      .catch(error => Promise.reject(error))
  }
}

export const coreApiClient = new ApiClient('http://localhost:3000')
export const recruitableApiClient = new ApiClient('http://localhost:3030')

/**
 * Base HTTP Client
 */
export default {
  // Provide request methods with the default base_url
  get(url, conf = {}) {
    return initClient().get(url, conf)
      .then(response => Promise.resolve(response))
      .catch(error => Promise.reject(error))
  },

  delete(url, conf = {}) {
    return initClient().delete(url, conf)
      .then(response => Promise.resolve(response))
      .catch(error => Promise.reject(error))
  },

  head(url, conf = {}) {
    return initClient().head(url, conf)
      .then(response => Promise.resolve(response))
      .catch(error => Promise.reject(error))
  },

  options(url, conf = {}) {
    return initClient().options(url, conf)
      .then(response => Promise.resolve(response))
      .catch(error => Promise.reject(error))
  },

  post(url, data = {}, conf = {}) {
    return initClient().post(url, data, conf)
      .then(response => Promise.resolve(response))
      .catch(error => Promise.reject(error))
  },

  put(url, data = {}, conf = {}) {
    return initClient().put(url, data, conf)
      .then(response => Promise.resolve(response))
      .catch(error => Promise.reject(error))
  },

  patch(url, data = {}, conf = {}) {
    return initClient().patch(url, data, conf)
      .then(response => Promise.resolve(response))
      .catch(error => Promise.reject(error))
  },
}
