const MessagesModule = {
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
    PUSH_MESSAGE(state, message) {
      const type = Object.keys(message).shift()

      state.messages.push({ text: message[type], type: type })
    },
    SHIFT_MESSAGE(state) {
      state.message = state.messages.shift()
    }
  },

  actions: {
    flash: context => {
      context.commit('SHIFT_MESSAGE')
      return Promise.resolve()
    }
  }
}

export default MessagesModule
