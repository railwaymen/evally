import _ from 'lodash'
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
    clearOne(state) {
      state.evaluation = new Evaluation()
      return state
    },
    one(state, evaluation_id) {
      state.evaluation = state.evaluations.find({ id: evaluation_id })
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
    progress(state, flag) {
      state.status = flag
      return state
    },
    remove(state, id) {
      state.evaluations.remove({ id: id })
      state.evaluation = new Evaluation()
      return state
    },
    replace(state, evaluation) {
      state.evaluations.map( el => {
        return el.id == evaluation.id ? evaluation : el
      })

      state.evaluations.sync()
      return state
    },
    resetOne(state) {
      state.evaluation.reset()
      return state
    },
    updateSkills(state, data) {
      _.map(state.evaluation.section_attributes, section => {
        if (section.id === data.sectionId) section.skills = data.skills
        return section
      })
      return state
    }
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
            context.commit('one', evaluation.id)

            resolve(response)
          })
          .catch(error => {
            reject(error)
          })
      })
    },
    update(context, evaluation) {
      return new Promise((resolve, reject) => {
        axios.put(context.state.evaluation.getFetchURL(), evaluation)
          .then(response => {
            let updated = new Evaluation(Utils.transformModel(response.data.data))

            context.commit('replace', updated)
            context.commit('one', updated.id)

            resolve(response)
          })
          .catch(error => {
            reject(error)
          })
      })
    },
    destroy(context) {
      return new Promise((resolve, reject) => {
        axios.delete(context.state.evaluation.getDeleteURL())
          .then(response => {
            let id = context.state.evaluation.id

            context.commit('remove', id)

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
