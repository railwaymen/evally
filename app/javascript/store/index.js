import Vue from 'vue'
import Vuex from 'vuex'

import AuthStore from './modules/auth_store'
import FlashStore from './modules/flash_store'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    AuthStore,
    FlashStore
  }
})
