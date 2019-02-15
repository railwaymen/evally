import Vue from 'vue'
import Vuex from 'vuex'

import ActivitiesStore from '@/store/modules/activities_store'
import AuthStore from '@/store/modules/auth_store'
import BrowserStore from '@/store/modules/browser_store'
import EmployeesStore from '@/store/modules/employees_store'
import EvaluationsStore from '@/store/modules/evaluations_store'
import FlashStore from '@/store/modules/flash_store'
import SectionsStore from '@/store/modules/sections_store'
import TemplatesStore from '@/store/modules/templates_store'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    ActivitiesStore,
    AuthStore,
    BrowserStore,
    EmployeesStore,
    EvaluationsStore,
    FlashStore,
    SectionsStore,
    TemplatesStore
  }
})
