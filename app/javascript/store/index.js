import Vue from 'vue'
import Vuex from 'vuex'

import AuthStore from './modules/auth_store'
import EmployeesStore from './modules/employees_store'
import FlashStore from './modules/flash_store'
import TemplatesStore from './modules/templates_store'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    AuthStore,
    EmployeesStore,
    FlashStore,
    TemplatesStore
  }
})
