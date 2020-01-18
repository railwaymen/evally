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
    list(state, templates) {
      state.templates = new TemplatesList(templates)
      state.loading = false
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
    }
  }
}

export default TemplatesModule
