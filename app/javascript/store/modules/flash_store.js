const FlashStore = {
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
    push: (state, message) => {
      let type = Object.keys(message).shift()
      state.messages.push({ text: message[type], type: type })
    },
    shift: state => {
      state.message = state.messages.shift()
    }
  },
  actions: {
    flash: context => {
      return new Promise((resolve, reject) => {
        context.commit('shift')
        resolve()
      })
    }
  }
}

export default FlashStore
