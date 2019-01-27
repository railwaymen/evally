import _ from 'lodash'
import axios from 'axios'

import { Utils } from '@/lib/utils'

import { Evaluation, EvaluationsList } from '@/models/evaluation'

const initialState = () => ({
  evaluations: new EvaluationsList(),
  evaluation: new Evaluation(),
  status: ''
})

const EvaluationsStore = {
  namespaced: true,

  state: initialState(),

  getters: {
    evaluations: state => state.evaluations,
    evaluationsDrafts: state => state.evaluations.filter(e => e.state === 'draft'),
    evaluation: state => state.evaluation,
    status: state => state.status
  },
  mutations: {
    clear(state) {
      state.evaluation.clear()
      return state
    },
    pick(state, id) {
      state.evaluation = state.evaluations.find({ id: id })
      return state
    },
    one(state, data) {
      state.evaluation = new Evaluation(data)
      return state
    },
    many(state, data) {
      state.evaluations.replace(data)
      state.status = 'ok'
      return state
    },
    push(state, data) {
      state.evaluations.add(data)
      return state
    },
    remove(state, id) {
      state.evaluations.remove({ id: id })
      state.evaluation.clear()
      return state
    },
    replace(state, evaluation) {
      state.evaluations.remove({ id: evaluation.id })
      state.evaluations.add(evaluation)
      return state
    },
    updateSkills(state, data) {
      _.map(state.evaluation.section_attributes, section => {
        if (section.id === data.sectionId) section.skills = data.skills
        return section
      })
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
    index(context, params) {
      return new Promise((resolve, reject) => {
        context.commit('progress', 'loading')

        axios.get(context.state.evaluations.getFetchURL(), { params: params })
          .then(response => {
            context.commit('many', response.data)
            resolve()
          })
          .catch(error => {
            reject(error)
          })
      })
    },
    show(context, token) {
      return new Promise((resolve, reject) => {
        context.commit('progress', 'loading')

        axios.get(`/v1/employees/${token}/evaluation`)
          .then(response => {
            context.commit('one', response.data)
            resolve()
          })
          .catch(error => {
            reject(error)
          })
      })
    },
    create(context, initialData) {
      return new Promise((resolve, reject) => {
        axios.post(context.state.evaluations.getFetchURL(), initialData)
          .then(response => {
            let evaluation = new Evaluation(response.data)

            context.commit('push', evaluation)
            context.commit('pick', evaluation.id)

            resolve()
          })
          .catch(error => {
            reject(error)
          })
      })
    },
    update(context, data) {
      return new Promise((resolve, reject) => {
        axios.put(context.state.evaluation.getFetchURL(), data)
          .then(response => {
            context.commit('replace', new Evaluation(response.data))
            resolve()
          })
          .catch(error => {
            reject(error)
          })
      })
    },
    destroy(context) {
      return new Promise((resolve, reject) => {
        axios.delete(context.state.evaluation.getFetchURL())
          .then(() => {
            context.commit('remove', context.state.evaluation.id)
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
