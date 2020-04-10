import { coreApiClient } from '@utils/api_clients'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { Template, TemplatesList } from '@models/template'
import { SectionsList } from '@models/section'

const initialState = () => ({
  templates: new TemplatesList(),
  destinations: [],
  template: new Template(),
  sections: new SectionsList(),
  loading: true
})

const TemplatesModule = {
  namespaced: true,

  state: initialState(),

  getters: {
    templates: state => state.templates,
    destinations: state => state.destinations,
    template: state => state.template,
    sections: state => state.sections,
    loading: state => state.loading
  },

  mutations: {
    addToList(state, data) {
      state.templates.add(data)
    },
    setEditable(state, value = true) {
      state.template.set('editable', value)
    },
    setItem(state, { template, sections }) {
      state.template = new Template(template)
      state.sections = new SectionsList(sections)
    },
    setList(state, { templates, destinations }) {
      state.templates = new TemplatesList(templates)
      state.destinations = destinations
      state.loading = false
    },
    setLoading(state, status) {
      state.loading = status
    },
    setSections(state, sectionsList) {
      state.sections = sectionsList
    },
    refreshListItem(state, template) {
      state.templates.refresh(template)
    },
    removeFromList(state, id) {
      state.template = new Template()
      state.sections = new SectionsList()
      state.templates.remove(id)
    },
    resetItem(state) {
      state.template = new Template()
      state.sections = new SectionsList()
    },
    resetState(state) {
      Object.assign(state, initialState())
    }
  },

  actions: {
    index({ commit }) {
      commit('setLoading', true)

      coreApiClient
        .get(Template.routes.templatesPath)
        .then(response => {
          commit('setList', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.templates.index.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('setLoading', false))
    },
    show({ commit }, id) {
      if (id === 'new') {
        commit('setItem', { template: { editable: true }, sections: [] })
      } else {
        coreApiClient
          .get(Template.routes.templatePath(id))
          .then(response => {
            commit('setItem', response.data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.templates.show.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      }
    },
    create({ state, commit }) {
      const { template, sections } = state;

      const params = {
        template: {
          ...template,
          sections: sections.models
        }
      }

      return (
        coreApiClient
          .post(Template.routes.templatesPath, params)
          .then(response => {
            commit('addToList', response.data.template)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.templates.create.ok') },
              { root: true }
            )

            return Promise.resolve(response.data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.templates.create.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    },
    update({ state, commit }) {
      const { template, sections } = state

      const params = {
        template: {
          ...template,
          sections: sections.models
        }
      }

      return (
        coreApiClient
          .put(Template.routes.templatePath(template.id), params)
          .then(response => {
            const { data } = response

            commit('refreshListItem', data.template)
            commit('setItem', data)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.templates.update.ok') },
              { root: true }
            )

            return Promise.resolve(data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.templates.update.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    },
    destroy({ state, commit }) {
      const { template } = state

      return (
        coreApiClient
          .delete(Template.routes.templatePath(template.id))
          .then(() => {
            commit('removeFromList', template.id)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.templates.delete.ok') },
              { root: true }
            )

            return Promise.resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.templates.delete.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      )
    }
  }
}

export default TemplatesModule
