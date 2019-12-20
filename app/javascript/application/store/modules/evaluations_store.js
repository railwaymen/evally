import http from '@/lib/http_config'

import { Evaluation, EvaluationsList } from '@models/evaluation'

const initialState = () => ({
  evaluations: new EvaluationsList(),
  evaluation: new Evaluation(),
  loading: true
})

const EvaluationsStore = {
  namespaced: true,

  state: initialState(),

  getters: {
    evaluations: state => state.evaluations,
    evaluation: state => state.evaluation,
    loading: state => state.loading
  },
  mutations: {
    list(state, data) {
      state.evaluations = new EvaluationsList(data)
      state.loading = false
      return state
    },
    inProgress(state, status) {
      state.loading = status
      return state
    },
    resetState(state) {
      state = Object.assign(state, initialState())
      return state
    }
  },
  actions: {
    drafts(context) {
      context.commit('inProgress', true)

      return new Promise((resolve, reject) => {
        http.get(Evaluation.routes.draftsEvaluations)
          .then(response => {
            context.commit('list', response.data)
            resolve()
          })
          .catch(error => {
            reject(error)
          })
      })
    }
  }
}

export default EvaluationsStore
