import axios from 'axios'

import { Template, TemplatesList } from '@/models/template'

const initialState = () => ({
  templates: new TemplatesList(),
  template: new Template(),
  status: ''
})

const TemplatesStore = {
  namespaced: true,

  state: initialState(),

  getters: {
    templates: state => state.templates,
    template: state => state.template,
    status: state => state.status
  },
  mutations: {
    clear(state) {
      state.template.clear()
      return state
    },
    one(state, data) {
      state.template = new Template(data)
      state.status = 'ok'
      return state
    },
    pick(state, id) {
      state.template = state.templates.find({ id: id })
      state.template.set('editable', false)
      return state
    },
    many(state, data) {
      state.templates.replace(data)
      state.status = 'ok'
      return state
    },
    push(state, template) {
      state.templates.add(template)
      return state
    },
    replace(state, template) {
      state.templates.remove({ id: template.id })
      state.templates.add(template)
      return state
    },
    remove(state, id) {
      state.templates.remove({ id: id })
      state.template.clear()
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
    index(context) {
      return new Promise((resolve, reject) => {
        context.commit('progress', 'loading')

        axios.get(context.state.templates.getFetchURL())
          .then(response => {
            context.commit('many', response.data)
          })
          .catch(error => {
            reject(error)
          })
      })
    },
    create(context, data) {
      return new Promise((resolve, reject) => {
        axios.post(context.state.templates.getFetchURL(), data)
          .then(response => {
            context.commit('push', new Template(response.data))
            context.commit('clear')
            resolve()
          })
          .catch(error => {
            reject(error)
          })
      })
    },
    update(context, data) {
      return new Promise((resolve, reject) => {
        axios.put(context.state.template.getFetchURL(), data)
          .then(response => {
            context.commit('replace', new Template(response.data))
            resolve()
          })
          .catch(error => {
            reject(error)
          })
      })
    },
    destroy(context) {
      return new Promise((resolve, reject) => {
        axios.delete(context.state.template.getFetchURL())
          .then(response => {
            context.commit('remove', context.state.template.id)
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
