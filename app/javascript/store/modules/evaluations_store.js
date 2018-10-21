import axios from 'axios'

import { Utils } from '../../lib/utils'

import { Evaluation, EvaluationsList } from '../../models/evaluation'

const EvaluationsStore = {
  namespaced: true,
  state: {
    evaluations: new EvaluationsList(),
    evaluation: new Evaluation(),
    status: ''

  },
  getters: {
    drafts: state => state.evaluations.filter(evaluation => evaluation.state === 'draft'),
    evaluation: state => state.evaluation,
    status: state => state.status

  },
  mutations: {
    many(state, data) {
      state.evaluations.replace(data)
      state.status = 'ok'
      return state
    },
    push(state, data) {
      state.evaluations.add(data)
      return state
    },
    progress(state, flag) {
      state.status = flag
      return state
    },
  },
  actions: {
    index(context) {
      return new Promise((resolve, reject) => {
        context.commit('progress', 'loading')

        axios.get(context.state.evaluations.getFetchURL())
          .then(response => {
            let data = Utils.modelsFromResponse(response.data.data)
            context.commit('many', data)
          })
          .catch(error => {
            reject(error)
          })
      })
    },
    create(context, initialData) {
      return new Promise((resolve, reject) => {
        axios.post(context.state.evaluation.getSaveURL(), initialData)
          .then(response => {
            let evaluation = new Evaluation(Utils.transformModel(response.data.data))

            context.commit('push', evaluation)

            resolve(response)
          })
          .catch(error => {
            reject(error)
          })
      })
    }
  }
}

export default EvaluationsStore
