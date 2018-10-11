import axios from 'axios'

import { Utils } from '../../lib/utils'
import { Template, TemplatesList } from '../../models/template'

const TemplatesStore = {
  namespaced: true,
  state: {
    templates: new TemplatesList(),
    template: new Template(),
    status: ''
  },
  getters: {
    templates: state => state.templates,
    template: state => state.template,
    editable: state => state.editable,
    status: state => state.status
  },
  mutations: {
    newTemplate(state) {
      state.template = new Template({ editable: true })
      state.status = 'new_record'
      return state
    },
    edit(state) {
      state.template.editable = true
      return state
    },
    one(state, template_id) {
      state.template = state.templates.find({ id: template_id })
      return state
    },
    many(state, data) {
      state.templates.replace(data)
      state.status = 'ok'
      return state
    },
    push(state, data) {
      state.templates.add(data)
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

        axios.get(context.state.templates.getFetchURL())
          .then(response => {
            let data = Utils.modelsFromResponse(response.data.data)

            context.commit('many', data)
          })
          .catch(error => {
            reject(error)
          })
      })
    },
    create(context, template) {
      return new Promise((resolve, reject) => {
        axios.post(context.state.template.getSaveURL(), template)
          .then(response => {
            let template = new Template(Utils.transformModel(response.data.data))

            context.commit('push', template)

            console.log(response)
            resolve(response)
          })
          .catch(error => {
            console.log(error)
            reject(error)
          })
      })
    }
  }
}

export default TemplatesStore
