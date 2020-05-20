import moment from 'moment'

import { recruitableApiClient } from '@utils/api_clients'
import { fetchError } from '@utils/helpers'

import i18n from '@locales/i18n'

import { RecruitDocument } from '@models/recruit_document'

const initialState = () => ({
  groups: [],
  groupsMonthlyChartData: [],
  groupsYearlyChartData: [],
  sources: [],
  sourcesMonthlyChartData: [],
  sourcesYearlyChartData: [],
  months: [],
  loading: false
})

const RecruitmentsOverviewModule = {
  namespaced: true,

  state: initialState(),

  mutations: {
    SET_DATA(state, data) {
      const {
        groups,
        groups_monthly_chart_data,
        groups_yearly_chart_data,
        sources,
        sources_monthly_chart_data,
        sources_yearly_chart_data,
        months
      } = data

      state.groups = groups
      state.groupsMonthlyChartData = groups_monthly_chart_data
      state.groupsYearlyChartData = groups_yearly_chart_data
      state.sources = sources
      state.sourcesMonthlyChartData = sources_monthly_chart_data
      state.sourcesYearlyChartData = sources_yearly_chart_data
      state.months = months.map(item => ({ value: item.month, text: moment(item.month).format('MMMM YYYY') }))
    },
    SET_LOADING(state, status) {
      state.loading = status
    },
    RESET_STATE(state) {
      Object.assign(state, initialState())
    }
  },

  actions: {
    fetchData({ commit }, date) {
      commit('SET_LOADING', true)

      recruitableApiClient
        .get(RecruitDocument.routes.recruitDocumentsOverviewPath, { params: { date } })
        .then(response => {
          commit('SET_DATA', response.data)
        })
        .catch((error) => {
          commit(
            'MessagesModule/PUSH_MESSAGE',
            { error: i18n.t('messages.employees.overview.error', { msg: fetchError(error) }) },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', false))
    }
  }
}

export default RecruitmentsOverviewModule
