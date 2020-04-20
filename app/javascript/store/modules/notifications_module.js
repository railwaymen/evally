const NotificationsModule = {
  namespaced: true,

  state: {
    messages: [],
    message: { text: '', type: 'info' }
  },

  getters: {
    hasMessage: state => state.messages.length > 0,
    message: state => state.message
  },

  mutations: {
    PUSH_NOTIFICATION(state, message) {
      const type = Object.keys(message).shift()

      state.messages.push({ text: message[type], type: type })
    },
    SHIFT_NOTIFICATION(state) {
      state.message = state.messages.shift()
    }
  },

  actions: {
    flash: context => {
      context.commit('SHIFT_NOTIFICATION')
      return Promise.resolve()
    }
  }
}

export default NotificationsModule
