import axios from 'axios'

import { EmployeesList } from '@/models/employee'

const initialState = () => ({
  skills: [],
  results: new EmployeesList(),
  query: {
    group: 'rating',
    name: null,
    comparator: 'eq',
    value: 0
  },
  status: ''
})

const BrowserStore = {
  namespaced: true,

  state: initialState,

  getters: {
    skills: state => state.skills,
    results: state => state.results,
    query: state => state.query,
    status: state => state.status
  },
  mutations: {
    many(state, data) {
      state.results.replace(data)
      state.status = 'ok'
      return state
    },
    manySkills(state, data) {
      state.skills = data
      state.status = 'ok'
      return state
    },
    save_query(state, query) {
      state.query = query
      return state
    },
    progress(state, flag) {
      state.status = flag
      return state
    },
    resetState(state) {
      state = Object.assign(state, initialState())
      return state
    }
  },
  actions: {
    search(context, params) {
      context.commit('save_query', params.query)

      return new Promise((resolve, reject) => {
        context.commit('progress', 'loading')

        axios.post('v1/employees/search', params)
          .then(response => {
            context.commit('many', response.data)
            resolve()
          })
          .catch(error => {
            reject(error)
          })
      })
    },

    skills(context) {
      return new Promise((resolve, reject) => {
        context.commit('progress', 'loading')

        axios.get('v1/employees/skills')
          .then(response => {
            context.commit('manySkills', response.data)
            resolve()
          })
          .catch(error => {
            reject(error)
          })
      })
    }
  }
}

export default BrowserStore
