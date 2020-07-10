import { EmailTemplate, EmailTemplatesList } from '@models/email_template'

const initState = () => ({
  emailTemplates: new EmailTemplatesList(),
  emailTemplate: new EmailTemplate(),
  loading: true
})

const EmailTemplatesModule = {
  namespaced: true,

  state: initState(),

  getters: {

  },

  mutations: {
    RESET_STATE(state) {
      Object.assign(state, initState())
    },
    SET_EDITABLE(state) {
      state.emailTemplate.editable = true
    },
    SET_LOADING(state, status) {
      state.loading = status
    },
    SET_TEMPLATE(state, { email_template }) {
      state.emailTemplate = new EmailTemplate(email_template)
    },
    SET_TEMPLATES(state, { email_templates }) {
      state.emailTemplates = new EmailTemplatesList(email_templates)
      state.loading = false
    }
  },

  actions: {
    fetchTemplates({ commit }) {
      commit('SET_TEMPLATES', {
        email_templates: [
          {
            id: 1,
            name: 'Feedback Email',
            subject: 'Recruitmen Process - Final Feedback',
            body: 'Lorem ipsum...',
            creator_id: 1,
            creator_fullname: 'John Doe'
          },
          {
            id: 2,
            name: 'Recruitment Task Email',
            subject: 'Recruitmen Process - Recruitment Task',
            body: 'Lorem ipsum...',
            creator_id: 1,
            creator_fullname: 'John Doe'
          }
        ]
      })

      commit('SET_LOADING', false)
    },
    fetchTemplate({ commit }, id) {
      if (id === 'new') {
        commit('SET_TEMPLATE', { email_template: { editable: true } })

        return
      }

      commit('SET_TEMPLATE', {
        email_template: {
          id: 2,
          name: 'Recruitment Task Email',
          subject: 'Recruitmen Process - Recruitment Task',
          body: 'Lorem ipsum...',
          creator_id: 1,
          creator_fullname: 'John Doe'
        }
      })
    }
  }
}

export default EmailTemplatesModule
