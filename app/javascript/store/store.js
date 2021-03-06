import Vue from 'vue'
import Vuex from 'vuex'

import AuthenticationModule from '@store/modules/authentication_module'
import DashboardModule from '@store/modules/dashboard_module'
import EmailsModule from '@store/modules/emails_module'
import EmailTemplatesModule from '@store/modules/email_templates_module'
import EvaluationEmployablesModule from '@store/modules/evaluation_employables_module'
import EmployeesModule from '@store/modules/employees_module'
import EmployeesOverviewModule from '@store/modules/employees_overview_module'
import EmployeesSearchModule from '@store/modules/employees_search_module'
import MessagesModule from '@store/modules/messages_module'
import NotificationsModule from '@store/modules/notifications_module'
import RecruitDocumentsModule from '@store/modules/recruit_documents_module'
import RecruitmentsInboxModule from '@store/modules/recruitments_inbox_module'
import RecruitmentsModule from '@store/modules/recruitments_module'
import RecruitmentsOverviewModule from '@store/modules/recruitments_overview_module'
import RecruitsSearchModule from '@store/modules/recruits_search_module'
import TemplatesModule from '@store/modules/templates_module'
import UsersModule from '@store/modules/users_module'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    AuthenticationModule,
    DashboardModule,
    EmailsModule,
    EmailTemplatesModule,
    EvaluationEmployablesModule,
    EmployeesModule,
    EmployeesOverviewModule,
    EmployeesSearchModule,
    MessagesModule,
    NotificationsModule,
    RecruitDocumentsModule,
    RecruitmentsInboxModule,
    RecruitmentsModule,
    RecruitmentsOverviewModule,
    RecruitsSearchModule,
    TemplatesModule,
    UsersModule
  }
})
