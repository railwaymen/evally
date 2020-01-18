import Vue from 'vue'
import Vuex from 'vuex'

import ActivitiesStore from '@/store/modules/activities_store'
import AuthStore from '@/store/modules/auth_store'
import BrowserStore from '@/store/modules/browser_store'
import EmployeesStore from '@/store/modules/employees_store'
import FlashStore from '@/store/modules/flash_store'
import SectionsStore from '@/store/modules/sections_store'

import DraftsModule from '@store/modules/drafts_module'
import TemplatesModule from '@store/modules/templates_module'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    ActivitiesStore,
    AuthStore,
    BrowserStore,
    EmployeesStore,
    FlashStore,
    SectionsStore,

    DraftsModule,
    TemplatesModule
  }
})
