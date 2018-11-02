import _ from 'lodash'
import axios from 'axios'

import { Utils } from '../../lib/utils'

import { Evaluation, EvaluationsList } from '../../models/evaluation'

const EvaluationsStore = {
  namespaced: true,
  state: {
    evaluations: new EvaluationsList(),
    evaluation: new Evaluation(),
    draft: new Evaluation(),
    status: ''

  },
  getters: {
    evaluations: state => state.evaluastions,
    drafts: state => state.evaluations.filter(evaluation => evaluation.state === 'draft'),
    completed: state => state.evaluations.filter(evaluation => evaluation.state === 'completed'),
    evaluation: state => state.evaluation,
    draft: state => state.draft,
    status: state => state.status
  },
  mutations: {
    clearDraft(state) {
      state.draft = new Evaluation()
      return state
    },
    clearEvaluation(state) {
      state.evaluation = new Evaluation()
      return state
    },
    oneDraft(state, evaluation_id) {
      state.draft = state.evaluations.find({ id: evaluation_id })
      return state
    },
    oneEvaluation(state, employee_id) {
      // evaluations are sorted descending on backend by completed_at property
      // find return the the most recent completed evaluation
      state.evaluation = state.evaluations.find(e => e.state === 'completed' && e.employee.id == employee_id)
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
    resetDraft(state) {
      state.draft.reset()
      return state
    },
    single(state, data) {
      state.evaluation = data
      return state
    },
    updateSkills(state, data) {
      _.map(state.draft.section_attributes, section => {
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
    show(context, token) {
      return new Promise((resolve, reject) => {
        context.commit('progress', 'loading')

        let url = `/v1/employees/${token}/evaluation`

        axios.get(url)
          .then(response => {
            let evaluation = new Evaluation(Utils.transformModel(response.data.data))

            context.commit('single', evaluation)
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
            context.commit('oneDraft', evaluation.id)

            resolve(response)
          })
          .catch(error => {
            reject(error)
          })
      })
    },
    update(context, data) {
      return new Promise((resolve, reject) => {
        axios.put(context.state.draft.getFetchURL(), data)
          .then(response => {
            let updated = new Evaluation(Utils.transformModel(response.data.data))

            context.commit('replace', updated)

            resolve(response)
          })
          .catch(error => {
            reject(error)
          })
      })
    },
    destroy(context) {
      return new Promise((resolve, reject) => {
        axios.delete(context.state.draft.getDeleteURL())
          .then(response => {
            let id = context.state.draft.id

            context.commit('remove', id)
            context.commit('clearDraft')

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
