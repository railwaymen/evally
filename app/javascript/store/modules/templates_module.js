import { coreApiClient } from '@utils/api_clients'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { Template, TemplatesList } from '@models/template'
import { SectionsList } from '@models/section'

const initState = () => ({
  templates: new TemplatesList(),
  destinations: [],
  template: new Template(),
  sections: new SectionsList(),
  loading: true
})

const TemplatesModule = {
  namespaced: true,

  state: initState(),

  mutations: {
    ADD_TEMPLATE(state, { template, sections }) {
      state.templates.unshift(template)
      state.template.assign({ ...template, editable: false })
      state.sections = new SectionsList(sections)
    },
    CLEAR_TEMPLATE(state) {
      state.template = new Template()
      state.sections = new SectionsList()
    },
    REFRESH_TEMPLATE(state, template) {
      state.templates.refresh(template)
      state.template.assign(template)
    },
    REMOVE_TEMPLATE(state, id) {
      state.template = new Template()
      state.sections = new SectionsList()
      state.templates.dropById(id)
    },
    RESET_STATE(state) {
      Object.assign(state, initState())
    },
    SET_EDITABLE(state) {
      state.template.editable = true
    },
    SET_LOADING(state, status) {
      state.loading = status
    },
    SET_SECTIONS(state, sections) {
      state.sections = new SectionsList(sections)
    },
    SET_TEMPLATE(state, { template, sections }) {
      state.template = new Template(template)
      state.sections = new SectionsList(sections)
    },
    SET_TEMPLATES(state, { templates, destinations }) {
      state.templates = new TemplatesList(templates)
      state.destinations = destinations
      state.loading = false
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

        return
      }

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
    },
    createTemplate({ state, commit }) {
      const { template, sections } = state;

      const params = {
        template: {
          ...template,
          sections: sections.models
        }
      }

      return new Promise(resolve => {
        coreApiClient
          .post(Template.routes.templatesPath, params)
          .then(response => {
            commit('ADD_TEMPLATE', response.data)
            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.templates.create.ok') },
              { root: true }
            )

            resolve(response.data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.templates.create.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    updateTemplate({ state, commit }) {
      const { template, sections } = state

      const params = {
        template: {
          ...template,
          sections: sections.models
        }
      }

      return new Promise(resolve => {
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

            resolve(data)
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.templates.update.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    },
    removeTemplate({ state, commit }) {
      const { template } = state

      return new Promise(resolve => {
        coreApiClient
          .delete(Template.routes.templatePath(template.id))
          .then(() => {
            commit('REMOVE_TEMPLATE', template.id)

            commit(
              'NotificationsModule/push',
              { success: i18n.t('messages.templates.delete.ok') },
              { root: true }
            )

            resolve()
          })
          .catch(error => {
            commit(
              'NotificationsModule/push',
              { error: i18n.t('messages.templates.delete.error', { msg: fetchError(error) }) },
              { root: true }
            )
          })
      })
    }
  }
}

export default TemplatesModule
