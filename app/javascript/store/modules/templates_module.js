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
    resetItem(state) {
      state.template = new Template()
      state.sections = new SectionsList()
      return state
    },
    setEditable(state, value = true) {
      state.template.set('editable', value)
      return state
    },
    addToList(state, data) {
      state.templates.add(data)
      return state
    },
    setList(state, templates) {
      state.templates = new TemplatesList(templates)
      state.loading = false
      return state
    },
    setItem(state, { template, sections }) {
      state.template = new Template(template)
      state.sections = new SectionsList(sections)
      return state
    },
    setLoading(state, status) {
      state.loading = status
      return state
    },
    setSections(state, sectionsList) {
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
      context.commit('setLoading', true)

      http.get(Template.routes.templatesPath)
        .then(response => {
          context.commit('setList', response.data)
        })
        .catch(() => {
          context.commit('FlashStore/push', { error: 'Error :(' }, { root: true })
        })
        .finally(() => context.commit('setLoading', false))
    },
    show(context, id) {
      if (id === 'new') {
        context.commit('setItem', { template: { editable: true }, sections: [] })
      } else {
        http.get(Template.routes.templatePath(id))
          .then(response => {
            context.commit('setItem', response.data)
          })
          .catch(() => {
            context.commit('FlashStore/push', { error: 'Error :(' }, { root: true })
          })
      }
    },
    create(context) {
      const { template, sections } = context.state;

      const params = {
        template: {
          ...template.attributes,
          sections: sections.models
        }
      }

      return new Promise((resolve, _reject) => {
        http.post(Template.routes.templatesPath, params)
          .then(response => {
            const { data } = response

            context.commit('addToList', data.template)
            context.commit('FlashStore/push', { success: 'Created :)' }, { root: true })

            resolve(data.template)
          })
          .catch(() => {
            context.commit('FlashStore/push', { error: 'Error :(' }, { root: true })
          })
      })
    },
    update(context) {
      const { template, sections } = context.state

      const params = {
        template: {
          ...template.attributes,
          sections: sections.models
        }
      }

      http.put(Template.routes.templatePath(template.id), params)
        .then(response => {
          context.commit('setItem', response.data)
          context.commit('FlashStore/push', { success: 'Updated :)' }, { root: true })
        })
        .catch(() => {
          context.commit('FlashStore/push', { error: 'Error :(' }, { root: true })
        })
    }
  }
}

export default TemplatesModule
