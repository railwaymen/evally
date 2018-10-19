import axios from 'axios'

import { Utils } from '../../lib/utils'

import { Evaluation } from '../../models/evaluation'

const EvaluationsStore = {
  namespaced: true,
  state: {
    evaluation: new Evaluation(),
    employee: null,
    template: null,
    status: ''

  },
  getters: {
    evaluation: state => state.evaluation,
    employee: state => state.employee,
    template: state => state.template,
    status: state => state.status

  },
  mutations: {

  },
  actions: {

  }
}

export default EvaluationsStore
