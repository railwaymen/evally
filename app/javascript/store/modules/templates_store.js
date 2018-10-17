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
      state.template.editable = false
      state.status = 'record'
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
    replace(state, template) {
      state.templates.map( el => {
        return el.id == template.id ? template : el
      })
      return state
    },
    remove(state, id) {
      state.templates.remove({ id: id })
      state.template = new Template()
      return state
    }
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

            resolve(response)
          })
          .catch(error => {
            console.log(error)
            reject(error)
          })
      })
    },
    update(context, template) {
      return new Promise((resolve, reject) => {
        axios.put(context.state.template.getFetchURL(), template)
          .then(response => {
            let updated = new Template(Utils.transformModel(response.data.data))

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
        axios.delete(context.state.template.getDeleteURL())
          .then(response => {
            let id = context.state.template.id

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

export default TemplatesStore
