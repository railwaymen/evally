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
    ADD_TEMPLATE(state, template) {
      state.templates.unshift(template)
    },
    SET_EDITABLE(state, value = true) {
      state.template.set('editable', value)
    },
    SET_TEMPLATE(state, { template, sections }) {
      state.template = new Template(template)
      state.sections = new SectionsList(sections)
    },
    SET_TEMPLATES(state, { templates, destinations }) {
      state.templates = new TemplatesList(templates)
      state.destinations = destinations
      state.loading = false
    },
    SET_LOADING(state, status) {
      state.loading = status
    },
    SET_SECTIONS(state, sectionsList) {
      state.sections = sectionsList
    },
    REFRESH_TEMPLATE(state, template) {
      state.templates.refresh(template)
    },
    REMOVE_TEMPLATE(state, id) {
      state.template = new Template()
      state.sections = new SectionsList()
      state.templates.dropById(id)
    },
    CLEAR_TEMPLATE(state) {
      state.template = new Template()
      state.sections = new SectionsList()
    },
    RESET_STATE(state) {
      Object.assign(state, initialState())
    }
  },

  actions: {
    fetchTemplates({ commit }) {
      commit('SET_LOADING', true)

      coreApiClient
        .get(Template.routes.templatesPath)
        .then(response => {
          commit('SET_TEMPLATES', response.data)
        })
        .catch(error => {
          commit(
            'NotificationsModule/push',
            { error: i18n.t('messages.templates.index.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', false))
    },
    fetchTemplate({ commit }, id) {
      if (id === 'new') {
        commit('SET_TEMPLATE', { template: { editable: true }, sections: [] })
      } else {
        coreApiClient
          .get(Template.routes.templatePath(id))
          .then(response => {
            commit('SET_TEMPLATE', response.data)
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
    createTemplate({ state, commit }) {
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
            commit('ADD_TEMPLATE', response.data.template)
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
    updateTempalte({ state, commit }) {
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

            commit('REFRESH_TEMPLATE', data.template)
            commit('SET_TEMPLATE', data)

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
    removeTemplate({ state, commit }) {
      const { template } = state

      return (
        coreApiClient
          .delete(Template.routes.templatePath(template.id))
          .then(() => {
            commit('REMOVE_TEMPLATE', template.id)

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
