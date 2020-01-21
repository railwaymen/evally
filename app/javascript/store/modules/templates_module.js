import http from '@/lib/http_config'

import { Template, TemplatesList } from '@models/template'
import { SectionsList } from '@models/section'

const initialState = () => ({
  templates: new TemplatesList(),
  template: new Template(),
  sections: new SectionsList(),
  loading: true
})

const TemplatesModule = {
  namespaced: true,

  state: initialState(),

  getters: {
    templates: state => state.templates,
    template: state => state.template,
    sections: state => state.sections,
    loading: state => state.loading
  },

  mutations: {
    clear(state) {
      state.template = new Template()
      state.sections = new SectionsList()
      return state
    },
    edit(state) {
      state.template.set('editable', true)
      return state
    },
    list(state, templates) {
      state.templates = new TemplatesList(templates)
      state.loading = false
      return state
    },
    item(state, { template, sections }) {
      state.template = new Template(template)
      state.sections = new SectionsList(sections)
      return state
    },
    inProgress(state, status) {
      state.loading = status
      return state
    },
    sectionsList(state, sectionsList) {
      state.sections = sectionsList
      return state
    },
    resetState(state) {
      state = Object.assign(state, initialState())
      return state
    }
  },

  actions: {
    index(context) {
      context.commit('inProgress', true)

      http.get(Template.routes.templatesPath)
        .then(response => {
          context.commit('list', response.data)
        })
        .catch(() => {
          context.commit('FlashStore/push', { error: 'Error :(' }, { root: true })
        })
    },
    show(context, id) {
      if (id === 'new') {
        context.commit('item', { template: { editable: true }, sections: [] })

        return
      }

      http.get(Template.routes.templatePath(id))
        .then(response => {
          context.commit('item', response.data)
        })
        .catch(() => {
          context.commit('FlashStore/push', { error: 'Error :(' }, { root: true })
        })
    },
    create(context) {
      console.log('Create: ', context.state)
    },
    update(context) {
      console.log('Update: ', context.state)
    }
  }
}

export default TemplatesModule
