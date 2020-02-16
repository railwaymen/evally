import Vue from 'vue'
import Vuex from 'vuex'

import DraftsModule from '@store/modules/drafts_module'
import EmployeesModule from '@store/modules/employees_module'
import EmployeesOverviewModule from '@store/modules/employees_overview_module'
import EmployeesSearchModule from '@store/modules/employees_search_module'
import NotificationsModule from '@store/modules/notifications_module'
import SessionModule from '@store/modules/session_module'
import TemplatesModule from '@store/modules/templates_module'
import UsersModule from '@store/modules/users_module'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    DraftsModule,
    EmployeesModule,
    EmployeesOverviewModule,
    EmployeesSearchModule,
    NotificationsModule,
    SessionModule,
    TemplatesModule,
    UsersModule
  }
})
