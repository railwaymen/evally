import Vue from 'vue'
import Vuex from 'vuex'

import ActivitiesStore from './modules/activities_store'
import AuthStore from './modules/auth_store'
import EmployeesStore from './modules/employees_store'
import EvaluationsStore from './modules/evaluations_store'
import FlashStore from './modules/flash_store'
import SectionsStore from './modules/sections_store'
import TemplatesStore from './modules/templates_store'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    ActivitiesStore,
    AuthStore,
    EmployeesStore,
    EvaluationsStore,
    FlashStore,
    SectionsStore,
    TemplatesStore
  }
})
