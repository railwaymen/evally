import Vue from 'vue'
import Vuex from 'vuex'

import DashboardModule from '@store/modules/dashboard_module'
import EvaluationEmployablesModule from '@store/modules/evaluation_employables_module'
import EmployeesModule from '@store/modules/employees_module'
import EmployeesOverviewModule from '@store/modules/employees_overview_module'
import EmployeesSearchModule from '@store/modules/employees_search_module'
import MessagesModule from '@store/modules/messages_module'
import NotificationsModule from '@store/modules/notifications_module'
import AuthenticationModule from '@store/modules/authentication_module'
import TemplatesModule from '@store/modules/templates_module'
import UsersModule from '@store/modules/users_module'
import RecruitDocumentsModule from '@store/modules/recruit_documents_module'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    DashboardModule,
    EvaluationEmployablesModule,
    EmployeesModule,
    EmployeesOverviewModule,
    EmployeesSearchModule,
    MessagesModule,
    NotificationsModule,
    AuthenticationModule,
    TemplatesModule,
    UsersModule,
    RecruitDocumentsModule
  }
})
