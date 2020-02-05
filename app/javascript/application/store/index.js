import Vue from 'vue'
import Vuex from 'vuex'

import ActivitiesStore from '@/store/modules/activities_store'
import BrowserStore from '@/store/modules/browser_store'
import SectionsStore from '@/store/modules/sections_store'

import DraftsModule from '@store/modules/drafts_module'
import EmployeesModule from '@store/modules/employees_module'
import EmployeesSearchModule from '@store/modules/employees_search_module'
import NotificationsModule from '@store/modules/notifications_module'
import SessionModule from '@store/modules/session_module'
import TemplatesModule from '@store/modules/templates_module'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    ActivitiesStore,
    BrowserStore,
    SectionsStore,

    DraftsModule,
    EmployeesModule,
    EmployeesSearchModule,
    NotificationsModule,
    SessionModule,
    TemplatesModule
  }
})
